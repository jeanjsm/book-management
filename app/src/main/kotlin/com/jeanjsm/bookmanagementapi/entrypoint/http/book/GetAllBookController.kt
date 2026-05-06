package com.jeanjsm.bookmanagementapi.entrypoint.http.book

import com.jeanjsm.bookmanagementapi.entities.BookEntity
import com.jeanjsm.bookmanagementapi.usecase.book.GetAllBookUseCase
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.data.domain.Sort
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/v1/book")
@Tag(name = "Book")
class GetAllBookController(
    private val getAllBookUseCase: GetAllBookUseCase
) {

    @CrossOrigin
    @GetMapping
    fun get(@RequestParam(defaultValue = "0", required = true) page: Int,
            @RequestParam(defaultValue = "10", required = true) size: Int,
            @RequestParam(defaultValue = "title") sortBy: String,
            @RequestParam(defaultValue = "ASC") sort: Sort.Direction,
            @RequestParam title: String?
    ): List<BookEntity> {
        return getAllBookUseCase.get(title, page, size, sortBy, sort.name)
    }

}