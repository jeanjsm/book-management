package com.jeanjsm.bookmanagementapi.provider.importer

import com.jeanjsm.bookmanagementapi.entities.vo.ImporterDto

interface CblProvider {

    fun searchByIsbn(isbn: String): List<ImporterDto>

}