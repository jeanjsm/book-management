package com.jeanjsm.bookmanagementapi.usecase.book

import com.jeanjsm.bookmanagementapi.provider.book.DeleteBookProvider
import jakarta.inject.Named

@Named
class DeleteBookUseCase(
    private val deleteBookProvider: DeleteBookProvider
) {

    fun exec(id: Long) {
        deleteBookProvider.delete(id)
    }

}