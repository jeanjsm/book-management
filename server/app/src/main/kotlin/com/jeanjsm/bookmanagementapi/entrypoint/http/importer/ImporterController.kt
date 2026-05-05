package com.jeanjsm.bookmanagementapi.entrypoint.http.importer

import com.jeanjsm.bookmanagementapi.entities.BookEntity
import com.jeanjsm.bookmanagementapi.entities.vo.ImporterDto
import com.jeanjsm.bookmanagementapi.provider.http.SkoobProviderImpl
import com.jeanjsm.bookmanagementapi.usecase.importer.ImporterUseCase
import com.jeanjsm.bookmanagementapi.usecase.importer.SearchDataComicUseCase
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/import")
class ImporterController(
    private val searchDataComicUseCase: SearchDataComicUseCase,
    private val importerUseCase: ImporterUseCase,
    private val skoobProviderImpl: SkoobProviderImpl
) {

    @GetMapping("/cbl/{isbn}")
    fun getCbl(@PathVariable isbn: String): List<ImporterDto> {
        return searchDataComicUseCase.searchIsbnCbl(isbn)
    }

    @GetMapping("/skoob/{isbn}")
    fun getSkoob(@PathVariable isbn: String): List<ImporterDto> {
        return searchDataComicUseCase.searchIsbnSkoob(isbn)
    }

    @PostMapping("/import/{isbn}")
    fun importIsbn(@PathVariable isbn: String, @RequestParam number: Int = 1) : BookEntity {
        return importerUseCase.execute(isbn, number)
    }

    @GetMapping("/image/{isbn}")
    fun getImageUrl(@PathVariable isbn: String): String {
        return importerUseCase.getImageUrl(isbn)
    }

}