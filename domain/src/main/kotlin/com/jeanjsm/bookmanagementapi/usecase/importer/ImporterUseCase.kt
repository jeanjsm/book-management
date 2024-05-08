package com.jeanjsm.bookmanagementapi.usecase.importer

import com.jeanjsm.bookmanagementapi.entities.BookEntity
import com.jeanjsm.bookmanagementapi.provider.importer.AmazonImageProvider
import com.jeanjsm.bookmanagementapi.usecase.book.CreateBookUseCase
import jakarta.inject.Named

@Named
class ImporterUseCase(
    private val searchDataComicUseCase: SearchDataComicUseCase,
    private val createBookUseCase: CreateBookUseCase,
    private val amazonImageProvider: AmazonImageProvider
) {

    fun execute(isbn: String, volumeNumber: Int): BookEntity {
        val response = searchDataComicUseCase.searchIsbnSkoob(isbn)
        return createBookUseCase.exec(BookEntity(
            code = response.first().id,
            title = response.first().title,
            number = volumeNumber,
            author = "",
            coverUrl = getImageUrl(isbn)
        ))
    }

    fun getImageUrl(isbn: String): String {
        return amazonImageProvider.getImageUrl(isbn)
    }

}