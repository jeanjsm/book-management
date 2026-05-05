package com.jeanjsm.bookmanagementapi.entrypoint.http.book

import com.jeanjsm.bookmanagementapi.entities.BookEntity
import com.jeanjsm.bookmanagementapi.provider.mysql.book.repository.BookModel
import com.jeanjsm.bookmanagementapi.provider.mysql.book.repository.BookRepository
import com.jeanjsm.bookmanagementapi.provider.mysql.book.repository.toModel
import com.jeanjsm.bookmanagementapi.usecase.book.CreateBookUseCase
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/v1/book")
@Tag(name = "Book")
class CreateBookController(
    private val createBookUseCase: CreateBookUseCase
) {

    @PostMapping
    fun create(@RequestBody bookEntity: BookEntity) : BookEntity {
        return createBookUseCase.exec(bookEntity)
    }
}