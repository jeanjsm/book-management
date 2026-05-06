package com.jsma.server.domain

import jakarta.persistence.*
import java.time.Instant

@Entity
@Table(name = "books")
data class Book(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,

    @Column(nullable = false)
    var title: String,

    @Column(nullable = true)
    var author: String? = null,

    @Column(nullable = true, unique = true)
    var isbn: String? = null,

    @Column(nullable = true)
    var publisher: String? = null,

    @Column(name = "publication_year")
    var publicationYear: Int? = null,

    @Column(nullable = false)
    val createdAt: Instant = Instant.now(),

    @Column(nullable = false)
    var updatedAt: Instant = Instant.now()
)
