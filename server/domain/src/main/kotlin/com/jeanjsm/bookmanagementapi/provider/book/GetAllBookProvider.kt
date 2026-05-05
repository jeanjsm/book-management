package com.jeanjsm.bookmanagementapi.provider.book

import com.jeanjsm.bookmanagementapi.entities.BookEntity
import org.springframework.data.domain.Page

interface GetAllBookProvider {

    fun get(title: String?, page: Int, size: Int, sortBy: String, sort: String) : Page<BookEntity>

}