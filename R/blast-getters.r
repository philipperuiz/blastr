
# Blast-Getters -------------------------------------------------------------

#' @importFrom IRanges IRanges
#' @importFrom IRanges RangedData
NULL

# query ============================
#
#' Getter methods for blast records
#' 
#' @param x A \code{\linkS4class{blastRecord}} object.
#' @param ... Additional arguments
#' 
#' @rdname blastReport-method
#' @docType methods
#' @export
setGeneric("query", function (x, ...) standardGeneric("query"))


#' @export
setMethod("query", "blastReport", function (x) x@query)


# index ============================
#
#' Getter methods for blast records
#' 
#' @param x A \code{\linkS4class{blastRecord}} object.
#' @param attributes Include definition as a name attribute.
#' 
#' @rdname blastReport-method
#' @export
setMethod("index", "blastReport",
          function (x, attributes = FALSE) {
            if (is.na(suppressWarnings(as.numeric(x@query$identifier)))) {
              message("No index")
              return(invisible(FALSE))
            }
            if (attributes) {
              setNames(as.numeric(x@query$identifier), nm=x@query$def)
            } else {
              as.numeric(x@query$identifier)
            }
          })


# hits ============================
#
#' Getter methods for blast records
#' 
#' @param x A \code{\linkS4class{blastRecord}}  object.
#' @param ... Additional arguments
#' 
#' @rdname blastReport-method
#' @docType methods
#' @export
setGeneric("hits", function (x, ...) standardGeneric("hits"))

#' @export
setMethod("hits", "blastReport", function (x) x@hits)


# getId ===========================
#
#' Getter methods for blast records
#' 
#' @usage getId(x, db="gi")
#' 
#' @param x A \code{\linkS4class{blastRecord}} or
#' \code{\linkS4class{hit}} object.
#' @param db Database tag (e.g.: 'gi', 'gb', 'emb', 'ref', 'gnl', ...)
#'
#' @return Accession numbers as specified by \code{db} for each hit.
#' 
#' @rdname blastReport-method
#' @docType methods
#' @export
setGeneric("getId", function (x, db="gi", ...) standardGeneric("getId"))


#' @export
setMethod("getId", "blastReport", function (x, db, ...) {
  lapply(x@hits, function (x) getId(x, db)) 
})


#' @export
setMethod("getId", "hit", function (x, db, ...) {
  id <- lapply(x@id, "[[", db)
  id[vapply(id, is.null, logical(1))] <- NA_character_
  unlist(id)
})


## getDesc =========================
##
#' Getter methods for blast records
#' 
#' @usage getDesc(x)
#' 
#' @param x A \code{\link{blastReport-class}} or \code{\link{hit-class}} object.
#' 
#' @return Description for each hit.
#' 
#' @rdname blastReport-method
#' @docType methods
#' @export
setGeneric("getDesc", function (x) standardGeneric("getDesc"))


#' @export
setMethod("getDesc", "blastReport", function (x) {
  lapply(x@hits, function (x) getDesc(x)) 
})


#' @export
setMethod("getDesc", "hit", function (x) {
  unlist(x@desc)
})


## getAccn =========================
##
#' Getter methods for blast records
#' 
#' @usage getAccn(x)
#' 
#' @param x A \code{\link{blastReport-class}} or \code{\link{hit-class}} object.
#' 
#' @return Accession number for each hit.
#' 
#' @rdname blastReport-method
#' @docType methods
#' @export
setGeneric("getAccn", function (x) standardGeneric("getAccn"))


#' @export
setMethod("getAccn", "blastReport", function (x) {
  lapply(x@hits, function (x) getAccn(x)) 
})


#' @export
setMethod("getAccn", "hit", function (x) unlist(x@accn) )


## getBitscore =====================
##
#' Getter methods for blast records
#' 
#' @usage getBitscore(x)
#' 
#' @param x A \code{\link{blastReport-class}} or \code{\link{hit-class}} object.
#' 
#' @return Bitscores for each hit.
#' 
#' @rdname blastReport-method
#' @docType methods
#' @export
setGeneric("getBitscore", function (x) standardGeneric("getBitscore"))


#' @export
setMethod("getBitscore", "blastReport", function (x) {
  lapply(x@hits, function (x) getBitscore(x)) 
})


#' @export
setMethod("getBitscore", "hit", function (x) unlist(x@hsp@bit_score) )


## getEvalue =======================
##
#' Getter methods for blast records
#' 
#' @usage getEvalue(x)
#' 
#' @param x A \code{\link{blastReport-class}} or \code{\link{hit-class}} object.
#' 
#' @return Evalue for each hit.
#' 
#' @rdname blastReport-method
#' @docType methods
#' @export
setGeneric("getEvalue", function (x) standardGeneric("getEvalue"))


#' @export
setMethod("getEvalue", "blastReport", function (x) {
  lapply(x@hits, function (x) getEvalue(x)) 
})


#' @export
setMethod("getEvalue", "hit", function (x) unlist(x@hsp@evalue) )


## getQueryRange ===================
##
#' Getter methods for blast records
#' 
#' @usage getQueryRange(x)
#' 
#' @param x A \code{\link{blastReport-class}} or \code{\link{hit-class}} object.
#' 
#' @return Start and end position for each query.
#' 
#' @rdname blastReport-method
#' @docType methods
#' @export
setGeneric("getQueryRange", function (x) standardGeneric("getQueryRange"))


#' @export
setMethod("getQueryRange", "hit", function (x) {
  frame <- x@hsp@query_frame
  start <- as.integer(ifelse(frame >= 0, x@hsp@query_from, x@hsp@query_to))
  end <- as.integer(ifelse(frame >= 0, x@hsp@query_to, x@hsp@query_from))
  RangedData(IRanges(start, end), frame = frame)
}) 


#' @export
setMethod("getQueryRange", "blastReport", function (x) {
  lapply(x@hits, getQueryRange) 
})


## getHitRange =====================
##
#' Getter methods for blast records
#' 
#' @usage getHitRange(x)
#' 
#' @param x A \code{\link{blastReport-class}} or \code{\link{hit-class}} object.
#' 
#' @return Start and end position for each hit.
#' 
#' @rdname blastReport-method
#' @docType methods
#' @export
setGeneric("getHitRange", function (x) standardGeneric("getHitRange"))


#' @export
setMethod("getHitRange", "hit", function (x) {
  frame <- x@hsp@hit_frame
  start <- as.integer(ifelse(frame >= 0, x@hsp@hit_from, x@hsp@hit_to))
  end <- as.integer(ifelse(frame >= 0, x@hsp@hit_to, x@hsp@hit_from))
  RangedData(IRanges(start, end), frame = frame)
})



#' @export
setMethod("getHitRange", "blastReport", function (x) {
  lapply(x@hits, getHitRange) 
})


## getHitFrame =====================
##
#' Getter methods for blast records
#' 
#' @usage getHitFrame(x)
#' 
#' @param x A \code{\link{blastReport-class}} or \code{\link{hit-class}} object.
#' 
#' @return Frame for each hit (1 or -1)
#' 
#' @rdname blastReport-method
#' @docType methods
#' @export
setGeneric("getHitFrame", function (x) standardGeneric("getHitFrame"))


#' @export
setMethod("getHitFrame", "blastReport", function (x) {
  lapply(x@hits, function (x) getHitFrame(x)) 
})


#' @export
setMethod("getHitFrame", "hit", function (x) x@hsp@hit_frame)


## getQuerySeq =====================
##
#' Getter methods for blast records
#' 
#' @usage getQuerySeq(x)
#' 
#' @param x A \code{\link{blastReport-class}} or \code{\link{hit-class}} object.
#' 
#' @return Query sequence(s) as a \code{\link[Biostrings]{DNAStringSet}}
#' 
#' @rdname blastReport-method
#' @docType methods
#' @export
setGeneric("getQuerySeq", function (x) standardGeneric("getQuerySeq"))


#' @export
setMethod("getQuerySeq", "blastReport", function (x) {
  lapply(x@hits, function (x) getQuerySeq(x)) 
})


#' @export
setMethod("getQuerySeq", "hit", function (x) x@hsp@qseq)


# getHitSeq =======================
#
#' Getter methods for blast records
#' 
#' @usage getHitSeq(x)
#' 
#' @param x A \code{\link{blastReport-class}} or \code{\link{hit-class}} object.
#' 
#' @return Hit sequence(s) as a \code{\link[Biostrings]{DNAStringSet}}
#' 
#' @rdname blastReport-method
#' @docType methods
#' @export
setGeneric("getHitSeq", function (x) standardGeneric("getHitSeq"))


#' @export
setMethod("getHitSeq", "blastReport", function (x) {
  lapply(x@hits, function (x) getHitSeq(x)) 
})


#' @export
setMethod("getHitSeq", "hit", function (x) x@hsp@hseq)





