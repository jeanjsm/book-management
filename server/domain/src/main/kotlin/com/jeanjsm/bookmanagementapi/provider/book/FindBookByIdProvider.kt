package com.jeanjsm.bookmanagementapi.provider.book

import com.jeanjsm.bookmanagementapi.entities.BookEntity

interface FindBookByIdProvider {

    fun exec(id: Long) : BookEntity?

}