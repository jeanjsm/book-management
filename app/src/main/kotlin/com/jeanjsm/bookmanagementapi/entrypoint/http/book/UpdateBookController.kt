package com.jeanjsm.bookmanagementapi.entrypoint.http.book

import com.jeanjsm.bookmanagementapi.entities.BookEntity
import com.jeanjsm.bookmanagementapi.entities.vo.UpdateBookRequest
import com.jeanjsm.bookmanagementapi.usecase.book.UpdateBookUseCase
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.web.bind.annotation.PatchMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/v1/book")
@Tag(name = "Book")
class UpdateBookController(
    private val updateBookUseCase: UpdateBookUseCase
) {

    @PatchMapping("/{id}")
    fun update(@PathVariable id: Long, @RequestBody updateBookRequest: UpdateBookRequest): BookEntity {
        return updateBookUseCase.update(id, updateBookRequest)
    }

}