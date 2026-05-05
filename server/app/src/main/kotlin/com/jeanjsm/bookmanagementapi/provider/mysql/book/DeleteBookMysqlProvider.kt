package com.jeanjsm.bookmanagementapi.provider.mysql.book

import com.jeanjsm.bookmanagementapi.provider.book.DeleteBookProvider
import com.jeanjsm.bookmanagementapi.provider.mysql.book.repository.BookRepository
import org.springframework.stereotype.Component

@Component
class DeleteBookMysqlProvider(
    private val repository: BookRepository
): DeleteBookProvider {
    override fun delete(id: Long) {
        repository.deleteById(id)
    }
}