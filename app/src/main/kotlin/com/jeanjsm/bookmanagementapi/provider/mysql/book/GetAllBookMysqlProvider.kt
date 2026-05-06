package com.jeanjsm.bookmanagementapi.provider.mysql.book

import com.jeanjsm.bookmanagementapi.entities.BookEntity
import com.jeanjsm.bookmanagementapi.provider.book.GetAllBookProvider
import com.jeanjsm.bookmanagementapi.provider.mysql.book.repository.BookRepository
import com.jeanjsm.bookmanagementapi.provider.mysql.book.repository.toEntity
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import org.springframework.stereotype.Component

@Component
class GetAllBookMysqlProvider(
    private val bookRepository: BookRepository
) : GetAllBookProvider {

    override fun get(title: String?, page: Int, size: Int, sortBy: String, sort: String): List<BookEntity> =
        bookRepository.findAllByFilter(title, PageRequest.of(page, size, Sort.by(Sort.Direction.valueOf(sort), sortBy))).map { it.toEntity() }

}