package com.jsma.server.service

import com.jsma.server.domain.Book
import com.jsma.server.domain.BookRepository
import com.jsma.server.error.NotFoundException
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class BookService(
    private val bookRepository: BookRepository
) {
    fun findById(id: Long): Book {
        return bookRepository.findById(id).orElseThrow {
            NotFoundException("Book not found with id=$id")
        }
    }

    fun findAll(): List<Book> = bookRepository.findAll()

    @Transactional
    fun create(book: Book): Book = bookRepository.save(book)

    @Transactional
    fun update(id: Long, updates: (Book) -> Unit): Book {
        val book = findById(id)
        updates(book)
        book.updatedAt = java.time.Instant.now()
        return bookRepository.save(book)
    }

    @Transactional
    fun deleteById(id: Long) {
        // Safe delete: if not found, throw controlled 404 instead of 500
        if (!bookRepository.existsById(id)) {
            throw NotFoundException("Book not found with id=$id")
        }
        bookRepository.deleteById(id)
    }
}
