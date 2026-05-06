package com.jeanjsm.bookmanagementapi.usecase.book

import com.jeanjsm.bookmanagementapi.entities.BookEntity
import com.jeanjsm.bookmanagementapi.provider.book.CreateBookProvider
import jakarta.inject.Named

@Named
class CreateBookUseCase(
    private val createBookProvider: CreateBookProvider
) {

    fun exec(bookEntity: BookEntity): BookEntity {
        return createBookProvider.create(bookEntity)
    }

}