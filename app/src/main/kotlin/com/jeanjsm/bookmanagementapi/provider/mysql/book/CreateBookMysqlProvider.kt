package com.jeanjsm.bookmanagementapi.provider.mysql.book

import com.jeanjsm.bookmanagementapi.entities.BookEntity
import com.jeanjsm.bookmanagementapi.provider.book.CreateBookProvider
import com.jeanjsm.bookmanagementapi.provider.mysql.book.repository.BookRepository
import com.jeanjsm.bookmanagementapi.provider.mysql.book.repository.toEntity
import com.jeanjsm.bookmanagementapi.provider.mysql.book.repository.toModel
import org.springframework.stereotype.Component

@Component
class CreateBookMysqlProvider(
    private val bookRepository: BookRepository
): CreateBookProvider {
    override fun create(bookEntity: BookEntity): BookEntity {
        return bookRepository.save(bookEntity.toModel()).toEntity()
    }
}