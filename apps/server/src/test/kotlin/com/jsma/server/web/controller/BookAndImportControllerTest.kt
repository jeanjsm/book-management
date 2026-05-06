package com.jsma.server.web.controller

import com.fasterxml.jackson.databind.ObjectMapper
import com.jsma.server.domain.Book
import com.jsma.server.domain.BookRepository
import com.jsma.server.domain.ImportJobRepository
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.http.MediaType
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.delete
import org.springframework.test.web.servlet.get
import org.springframework.test.web.servlet.patch
import org.springframework.test.web.servlet.post

@SpringBootTest
@AutoConfigureMockMvc
class BookAndImportControllerTest {

    @Autowired
    lateinit var mockMvc: MockMvc

    @Autowired
    lateinit var bookRepository: BookRepository

    @Autowired
    lateinit var importJobRepository: ImportJobRepository

    @Autowired
    lateinit var objectMapper: ObjectMapper

    @BeforeEach
    fun setUp() {
        importJobRepository.deleteAll()
        bookRepository.deleteAll()
    }

    @Test
    fun `GET v1-book-id with nonexistent id must return 404 and not 500`() {
        mockMvc.get("/v1/book/99999") {
            accept = MediaType.APPLICATION_JSON
        }.andExpect {
            status { isNotFound() }
            jsonPath("$.status") { value(404) }
            jsonPath("$.code") { value("NOT_FOUND") }
            jsonPath("$.message") { value("Book not found with id=99999") }
            jsonPath("$.trace") { doesNotExist() }
        }
    }

    @Test
    fun `PATCH v1-book-id with nonexistent id must return 404 and not 500`() {
        val body = mapOf("title" to "Updated Title")
        mockMvc.patch("/v1/book/99999") {
            contentType = MediaType.APPLICATION_JSON
            content = objectMapper.writeValueAsString(body)
        }.andExpect {
            status { isNotFound() }
            jsonPath("$.status") { value(404) }
            jsonPath("$.code") { value("NOT_FOUND") }
            jsonPath("$.message") { value("Book not found with id=99999") }
            jsonPath("$.trace") { doesNotExist() }
        }
    }

    @Test
    fun `DELETE v1-book-id with nonexistent id must return 404 and not 500`() {
        mockMvc.delete("/v1/book/99999") {
            accept = MediaType.APPLICATION_JSON
        }.andExpect {
            status { isNotFound() }
            jsonPath("$.status") { value(404) }
            jsonPath("$.code") { value("NOT_FOUND") }
            jsonPath("$.message") { value("Book not found with id=99999") }
            jsonPath("$.trace") { doesNotExist() }
        }
    }

    @Test
    fun `PATCH v1-book-id with existing id must succeed`() {
        val book = bookRepository.save(
            Book(title = "Original", author = "Author")
        )
        val body = mapOf("title" to "Updated")
        mockMvc.patch("/v1/book/${book.id}") {
            contentType = MediaType.APPLICATION_JSON
            content = objectMapper.writeValueAsString(body)
        }.andExpect {
            status { isOk() }
            jsonPath("$.title") { value("Updated") }
            jsonPath("$.author") { value("Author") }
        }
    }

    @Test
    fun `DELETE v1-book-id with existing id must return 204`() {
        val book = bookRepository.save(
            Book(title = "To Delete", author = "Author")
        )
        mockMvc.delete("/v1/book/${book.id}") {
            accept = MediaType.APPLICATION_JSON
        }.andExpect {
            status { isNoContent() }
        }
    }

    @Test
    fun `POST import-import-isbn with empty result must return 200 and not 500`() {
        mockMvc.post("/import/import/1234567890?number=1") {
            accept = MediaType.APPLICATION_JSON
        }.andExpect {
            status { isOk() }
            jsonPath("$.isbn") { value("1234567890") }
            jsonPath("$.status") { value("COMPLETED_EMPTY") }
            jsonPath("$.booksImported") { value(0) }
            jsonPath("$.trace") { doesNotExist() }
        }
    }

    @Test
    fun `error response must not expose trace field with stacktrace`() {
        mockMvc.get("/v1/book/99999") {
            accept = MediaType.APPLICATION_JSON
        }.andExpect {
            status { isNotFound() }
            jsonPath("$.trace") { doesNotExist() }
            jsonPath("$.message") { exists() }
            jsonPath("$.timestamp") { exists() }
            jsonPath("$.status") { exists() }
            jsonPath("$.code") { exists() }
        }
    }
}
