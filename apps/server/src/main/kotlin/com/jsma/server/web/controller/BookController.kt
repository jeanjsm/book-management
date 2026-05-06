package com.jsma.server.web.controller

import com.jsma.server.domain.Book
import com.jsma.server.service.BookService
import com.jsma.server.web.dto.BookCreateRequest
import com.jsma.server.web.dto.BookPatchRequest
import com.jsma.server.web.dto.BookResponse
import jakarta.validation.Valid
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/v1/book")
class BookController(
    private val bookService: BookService
) {

    @GetMapping("/{id}")
    fun getById(@PathVariable id: Long): ResponseEntity<BookResponse> {
        val book = bookService.findById(id)
        return ResponseEntity.ok(BookResponse.from(book))
    }

    @GetMapping
    fun list(): ResponseEntity<List<BookResponse>> {
        return ResponseEntity.ok(bookService.findAll().map { BookResponse.from(it) })
    }

    @PostMapping
    fun create(@Valid @RequestBody request: BookCreateRequest): ResponseEntity<BookResponse> {
        val book = Book(
            title = request.title,
            author = request.author,
            isbn = request.isbn,
            publisher = request.publisher,
            publicationYear = request.year
        )
        val saved = bookService.create(book)
        return ResponseEntity.status(HttpStatus.CREATED).body(BookResponse.from(saved))
    }

    @PatchMapping("/{id}")
    fun patch(
        @PathVariable id: Long,
        @Valid @RequestBody request: BookPatchRequest
    ): ResponseEntity<BookResponse> {
        val updated = bookService.update(id) { book ->
            request.title?.let { book.title = it }
            request.author?.let { book.author = it }
            request.isbn?.let { book.isbn = it }
            request.publisher?.let { book.publisher = it }
            request.year?.let { book.publicationYear = it }
        }
        return ResponseEntity.ok(BookResponse.from(updated))
    }

    @DeleteMapping("/{id}")
    fun delete(@PathVariable id: Long): ResponseEntity<Void> {
        // Safe delete: returns 404 if book not found (no 500)
        bookService.deleteById(id)
        return ResponseEntity.noContent().build()
    }
}
