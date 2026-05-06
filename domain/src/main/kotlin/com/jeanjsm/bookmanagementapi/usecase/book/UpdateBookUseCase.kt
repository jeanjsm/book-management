package com.jeanjsm.bookmanagementapi.usecase.book

import com.jeanjsm.bookmanagementapi.entities.BookEntity
import com.jeanjsm.bookmanagementapi.entities.vo.UpdateBookRequest
import com.jeanjsm.bookmanagementapi.provider.book.FindBookByIdProvider
import jakarta.inject.Named

@Named
class UpdateBookUseCase(
    private val findBookByIdProvider: FindBookByIdProvider,
    private val saveBookUseCase: CreateBookUseCase
) {

    fun update(id: Long, updateBookRequest: UpdateBookRequest): BookEntity {
        val book = findBookByIdProvider.exec(id)
            ?: throw NoSuchElementException("Não foi encontrado nenhum book com esse id=$id")

        val bookUpdated = book.copy(title = updateBookRequest.title ?: book.title, author = updateBookRequest.author
            ?: book.author, number = updateBookRequest.number ?: book.number)

        return saveBookUseCase.exec(bookUpdated)
    }

}