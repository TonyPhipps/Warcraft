

A little helper for posting auctions. NO VISUAL CHANGE to the interface is made.

Features:

    Automatically scans existing auctions and undercut prices.
    When no existing matching auctions are found, sets a starting price and buyout price based on either vendor price or item quality.
    Automatically select a duration for new auctions (default of 48h).


Options (customize in Options.lua file):

    UNDERCUT - Percentage of lowest auction to set your new auction prices at.
    PRICEBY - When no matches are found, set price by VENDOR or QUALITY
        VENDOR (default) - Price is set based on vendor price, then multiplied based on quality.
        QUALITY - Price is set based on quality alone (e.g. 250(g) for all greens).

