package com.jeanjsm.bookmanagementapi.provider.importer

import com.jeanjsm.bookmanagementapi.entities.vo.ImporterDto

interface ImporterProvider {

    fun getSource() : String
    fun searchByIsbn(isbn: String): List<ImporterDto>

}