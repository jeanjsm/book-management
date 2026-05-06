package com.jeanjsm.bookmanagementapi.usecase.importer

import com.jeanjsm.bookmanagementapi.entities.vo.CblResultDto
import com.jeanjsm.bookmanagementapi.entities.vo.ImporterDto
import com.jeanjsm.bookmanagementapi.provider.importer.ImporterProvider
import jakarta.inject.Named

@Named
class SearchDataComicUseCase(
    private val importersProvider: List<ImporterProvider>
) {

    fun searchIsbnCbl(isbn: String): List<ImporterDto> {
        return importersProvider.first { it.getSource() == "CBL" }.searchByIsbn(isbn)
    }
    fun searchIsbnSkoob(isbn: String): List<ImporterDto> {
        return importersProvider.first { it.getSource() == "SKOOB" }.searchByIsbn(isbn)
    }

}