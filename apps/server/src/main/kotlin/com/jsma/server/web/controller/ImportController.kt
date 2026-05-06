package com.jsma.server.web.controller

import com.jsma.server.service.ImportService
import com.jsma.server.web.dto.ImportResponse
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/import")
class ImportController(
    private val importService: ImportService
) {

    @PostMapping("/import/{isbn}")
    fun importByIsbn(
        @PathVariable isbn: String,
        @RequestParam(name = "number", required = false) number: Int?
    ): ResponseEntity<ImportResponse> {
        val result = importService.importByIsbn(isbn, number)
        val job = result.job
        return ResponseEntity.ok(
            ImportResponse(
                id = job.id ?: 0,
                isbn = job.isbn,
                number = job.number,
                status = job.status,
                booksImported = result.booksImported,
                createdAt = job.createdAt
            )
        )
    }
}
