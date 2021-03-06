# ---------------------------------------
# Author: Andreas Alfons
#         Vienna University of Technology
# ---------------------------------------



#' Alphablending for colors
#' 
#' Convert colors to semitransparent colors.
#' 
#' 
#' @param col a vector specifying colors.
#' @param alpha a numeric vector containing the alpha values (between 0 and 1).
#' @param bg the background color to be used for alphablending.  This can be
#' used as a workaround for graphics devices that do not support
#' semitransparent colors.
#' @return a vector containing the semitransparent colors.
#' @author Andreas Alfons
#' @keywords color
#' @examples
#' 
#' alphablend("red", 0.6)
#' 
#' @export alphablend
alphablend <- function(col, alpha = NULL, bg = NULL) {
    if(length(alpha) == 0) col
    else {
        alpha <- rep(alpha, length.out=length(col))
        if(length(bg) == 0) {
            colrgb <- col2rgb(col)/255
            rgb(colrgb[1,], colrgb[2,], colrgb[3,], alpha)
        } else {
            if(any(alpha < 0 | alpha > 1)) {
                stop("values in 'alpha' must be between 0 and 1")
            }
            colrgb <- col2rgb(col)/255
            bgrgb <- as.vector(col2rgb(bg[1])/255)
            red <- alpha*colrgb[1,] + (1-alpha)*bgrgb[1]
            green <- alpha*colrgb[2,] + (1-alpha)*bgrgb[2]
            blue <- alpha*colrgb[3,] + (1-alpha)*bgrgb[3]
            mapply(rgb, red, green, blue)
        }
    }
}
