package com.jeanjsm.bookmanagementapi.usecase.book

import com.jeanjsm.bookmanagementapi.entities.BookEntity
import com.jeanjsm.bookmanagementapi.provider.book.GetAllBookProvider
import jakarta.inject.Named

@Named
class GetAllBookUseCase(
    private val getAllBookProvider: GetAllBookProvider
) {

    fun get(title: String?, page: Int, size: Int, sortBy: String, sort: String): List<BookEntity> =
        getAllBookProvider.get(title, page, size, sortBy, sort)

}