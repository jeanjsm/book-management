package com.jsma.server.web.dto

import com.fasterxml.jackson.annotation.JsonProperty
import com.jsma.server.domain.Book
import java.time.Instant

data class BookResponse(
    val id: Long,
    val title: String,
    val author: String?,
    val isbn: String?,
    val publisher: String?,
    @JsonProperty("year")
    val publicationYear: Int?,
    val createdAt: Instant,
    val updatedAt: Instant
) {
    companion object {
        fun from(book: Book): BookResponse = BookResponse(
            id = book.id ?: 0,
            title = book.title,
            author = book.author,
            isbn = book.isbn,
            publisher = book.publisher,
            publicationYear = book.publicationYear,
            createdAt = book.createdAt,
            updatedAt = book.updatedAt
        )
    }
}
