#' Dynamic representation
#' 
#' Specify an object and a format to represent it in. Will \link{stop()} if no such format is known.
#' 
#' @return A \code{class(obj) = 'repr'} object of that format or NULL if none is defined.
#' Only the \code{'text'} format is defined for everything (via \link{print()})
#' 
#' @export
repr <- function(obj, format = 'text', ...) {
	delegate <- format2repr[[format]]
	if (is.null(delegate)) stop(sprintf('Repr format %s not known', format))
	delegate(obj, ...)
}

#' Extract repr format attribute
#' 
#' @export
repr.format <- function(r) attr(r, 'repr.format')

#' Text representation
#' 
#' The only representation defined per default for everthing (via \link{print()})
#'
#' @export
repr_text <- function (obj, ...) UseMethod('repr_text', obj)
#' @export
repr_text.default <- function(obj, ...) {
	txt <- paste(capture.output(print(obj)), collapse = '\n')
	structure(txt, class = 'repr', repr.format = 'text')
}
repr_text.repr <- function(r, ...) if (repr.format(r) != 'text') NULL else r

#' HTML representation
#' 
#' @export
repr_html <- function (obj, ...) UseMethod('repr_html', obj)
#' @export
repr_html.default <- function(obj, ...) NULL
repr_html.repr <- function(r, ...) if (repr.format(r) != 'html') NULL else r

#' Markdown representation
#' 
#' @export
repr_markdown <- function (obj, ...) UseMethod('repr_markdown', obj)
#' @export
repr_markdown.default <- function(obj, ...) NULL
repr_markdown.repr <- function(r, ...) if (repr.format(r) != 'markdown') NULL else r

#' LaTeX representation
#' 
#' @export
repr_latex <- function (obj, ...) UseMethod('repr_latex', obj)
#' @export
repr_latex.default <- function(obj, ...) NULL
repr_latex.repr <- function(r, ...) if (repr.format(r) != 'latex') NULL else r

#' JSON representation
#' 
#' @export
repr_json <- function (obj, ...) UseMethod('repr_json', obj)
#' @export
repr_json.default <- function(obj, ...) NULL
repr_json.repr <- function(r, ...) if (repr.format(r) != 'json') NULL else r

#' Javascript representation
#' 
#' @export
repr_javascript <- function (obj, ...) UseMethod('repr_javascript', obj)
#' @export
repr_javascript.default <- function(obj, ...) NULL
repr_javascript.repr <- function(r, ...) if (repr.format(r) != 'javascript') NULL else r

#' PDF representation
#' 
#' @export
repr_pdf <- function (obj, ...) UseMethod('repr_pdf', obj)
#' @export
repr_pdf.default <- function(obj, ...) NULL
repr_pdf.repr <- function(r, ...) if (repr.format(r) != 'pdf') NULL else r

#' PNG representation
#' 
#' @export
repr_png <- function (obj, ...) UseMethod('repr_png', obj)
#' @export
repr_png.default <- function(obj, ...) NULL
repr_png.repr <- function(r, ...) if (repr.format(r) != 'png') NULL else r

#' JPG representation
#' 
#' @export
repr_jpg <- function (obj, ...) UseMethod('repr_jpg', obj)
#' @export
repr_jpg.default <- function(obj, ...) NULL
repr_jpg.repr <- function(r, ...) if (repr.format(r) != 'jpg') NULL else r

#' SVG representation
#' 
#' @export
repr_svg <- function (obj, ...) UseMethod('repr_svg', obj)
#' @export
repr_svg.default <- function(obj, ...) NULL
repr_svg.repr <- function(r, ...) if (repr.format(r) != 'svg') NULL else r


#' @export
mime2repr <- list(
	'text/plain' = repr_text,
	'text/html' = repr_html,
	'text/markdown' = repr_markdown,
	'text/latex' = repr_latex,
	'application/json' = repr_json,
	'application/javascript' = repr_javascript,
	'application/pdf' = repr_pdf,
	'image/png' = repr_png,
	'image/jpeg' = repr_jpg,
	'image/svg+xml' = repr_svg)

#' @export
format2repr <- sapply(
	c('text', 'html', 'markdown', 'latex', 'json', 'javascript', 'pdf', 'png', 'jpg', 'svg'),
	function(n) get(paste0('repr_', n)))
