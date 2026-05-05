package com.jeanjsm.bookmanagementapi.provider.book

import com.jeanjsm.bookmanagementapi.entities.BookEntity

interface CreateBookProvider {

    fun create(bookEntity: BookEntity) : BookEntity

}