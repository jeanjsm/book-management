package com.jeanjsm.bookmanagementapi.entrypoint.http.book

import com.jeanjsm.bookmanagementapi.entities.BookEntity
import com.jeanjsm.bookmanagementapi.provider.mysql.book.repository.BookModel
import com.jeanjsm.bookmanagementapi.provider.mysql.book.repository.BookRepository
import com.jeanjsm.bookmanagementapi.provider.mysql.book.repository.toModel
import com.jeanjsm.bookmanagementapi.usecase.book.CreateBookUseCase
import com.jeanjsm.bookmanagementapi.usecase.book.DeleteBookUseCase
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/v1/book")
@Tag(name = "Book")
class DeleteBookController(
    private val deleteBookUseCase: DeleteBookUseCase
) {

    @CrossOrigin
    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    fun get(@PathVariable id: Long) {
        deleteBookUseCase.exec(id)
    }
}