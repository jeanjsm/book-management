package com.jsma.server.domain

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface BookRepository : JpaRepository<Book, Long> {
    fun findByIsbn(isbn: String): Book?
}
