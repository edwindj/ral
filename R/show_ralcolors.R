#' Show color table of RAL colors
#' 
#' Show color table of RAL colors
#' @export
#' @seealso \code{\link{ral}}
#' @importFrom graphics par plot rect text
  show_ralcolors <- function () 
{
  ral <- ral::ral
  colors <- ral$color
  labels <- ral$RAL
  borders <- FALSE
  n <- length(colors)
  ncol <- ceiling(sqrt(n))
  nrow <- ceiling(n/ncol)
  colors <- c(colors, rep(NA, nrow * ncol - length(colors)))
  labels <- c(labels, rep("", nrow * ncol - length(labels)))
  colors <- matrix(colors, ncol = ncol, byrow = TRUE)
  labels <- matrix(labels, ncol=ncol, byrow=TRUE)
  old <- par(pty = "s", mar = c(0, 0, 0, 0))
  on.exit(par(old))
  size <- max(dim(colors))
  plot(c(0, size), c(0, -size), type = "n", xlab = "", ylab = "", 
       axes = FALSE)
  rect(col(colors) - 1, -row(colors) + 1, col(colors), -row(colors), 
       col = colors, border = borders)
  if (!missing(labels)) {
    text(col(colors) - 0.5, -row(colors) + 0.5, labels, cex=0.6)
  }
}