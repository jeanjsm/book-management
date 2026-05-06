package com.jeanjsm.bookmanagementapi.provider.mysql.book.repository

import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query

interface BookRepository : JpaRepository<BookModel, Long> {

    @Query("select b from BookModel b where 1=1 and (:title is null or upper(b.title) like upper(concat('%', :title, '%')))")
    fun findAllByFilter(title: String?, pageable: Pageable) : List<BookModel>

}