package com.jsma.server.service

import com.jsma.server.domain.Book
import com.jsma.server.domain.BookRepository
import com.jsma.server.domain.ImportJob
import com.jsma.server.domain.ImportJobRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class ImportService(
    private val bookRepository: BookRepository,
    private val importJobRepository: ImportJobRepository
) {
    @Transactional
    fun importByIsbn(isbn: String, number: Int?): ImportResult {
        val job = importJobRepository.save(
            ImportJob(isbn = isbn, number = number, status = "PENDING")
        )

        // Simulated import logic: resolve book from a source.
        // If nothing resolved, books list is empty.
        val books: List<Book> = resolveBooks(isbn, number)

        if (books.isEmpty()) {
            val updated = job.copy(
                status = "COMPLETED_EMPTY",
                result = "No books found for ISBN=$isbn"
            )
            importJobRepository.save(updated)
            return ImportResult(
                job = updated,
                booksImported = 0
            )
        }

        val saved = books.map { bookRepository.save(it) }
        val updated = job.copy(
            status = "COMPLETED",
            result = "Imported ${saved.size} book(s) for ISBN=$isbn"
        )
        importJobRepository.save(updated)
        return ImportResult(job = updated, booksImported = saved.size)
    }

    // Simulated external lookup; returns empty list for this demo.
    private fun resolveBooks(isbn: String, number: Int?): List<Book> {
        // In real integration this would call an external API.
        // For the bug scenario, if no results are found we return an empty list
        // rather than throwing an NPE or unhandled exception that would cause 500.
        @Suppress("UNUSED_VARIABLE")
        val _unused = isbn to number
        return emptyList()
    }

    data class ImportResult(
        val job: ImportJob,
        val booksImported: Int
    )
}
