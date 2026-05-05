package com.jeanjsm.bookmanagementapi.provider.mysql.book

import com.jeanjsm.bookmanagementapi.entities.BookEntity
import com.jeanjsm.bookmanagementapi.provider.book.FindBookByIdProvider
import com.jeanjsm.bookmanagementapi.provider.mysql.book.repository.BookRepository
import com.jeanjsm.bookmanagementapi.provider.mysql.book.repository.toEntity
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Component

@Component
class FindBookByIdMysqlProvider(
    private val repository: BookRepository
) : FindBookByIdProvider {
    override fun exec(id: Long): BookEntity? {
        return repository.findByIdOrNull(id)?.toEntity()
    }
}