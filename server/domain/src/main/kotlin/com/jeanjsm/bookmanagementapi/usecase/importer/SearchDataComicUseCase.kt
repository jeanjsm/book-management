package com.jeanjsm.bookmanagementapi.usecase.importer

import com.jeanjsm.bookmanagementapi.entities.vo.CblResultDto
import com.jeanjsm.bookmanagementapi.entities.vo.ImporterDto
import com.jeanjsm.bookmanagementapi.provider.importer.ImporterProvider
import jakarta.inject.Named
import java.util.logging.Logger

@Named
class SearchDataComicUseCase(
    private val importersProvider: List<ImporterProvider>
) {
    companion object {
        private val logger = Logger.getLogger(SearchDataComicUseCase::class.java.name)
    }

    fun searchIsbnCbl(isbn: String): List<ImporterDto> {
        return try {
            importersProvider.first { it.getSource() == "CBL" }.searchByIsbn(isbn)
        } catch (e: Exception) {
            logger.warning("Failed to search CBL for ISBN $isbn: ${e.message}")
            emptyList()
        }
    }

    fun searchIsbnSkoob(isbn: String): List<ImporterDto> {
        return try {
            importersProvider.first { it.getSource() == "SKOOB" }.searchByIsbn(isbn)
        } catch (e: Exception) {
            logger.warning("Failed to search Skoob for ISBN $isbn: ${e.message}")
            emptyList()
        }
    }

}