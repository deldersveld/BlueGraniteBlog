let
    Source = Text.FromBinary(Web.Contents("http://financials.morningstar.com/financials/getKeyStatPart.html?&t=XNAS:MSFT")),
    A = Text.Replace(Source, "\", ""),
    B = Text.Replace(A, "display:none", "display:block"),
    C = Web.Page(B),
    Data = C{6}[Data],
    D = Table.TransformColumnTypes(Data,{{"Efficiency", type text}, {"2005-06", type number}, {"2006-06", type number}, {"2007-06", type number}, {"2008-06", type number}, {"2009-06", type number}, {"2010-06", type number}, {"2011-06", type number}, {"2012-06", type number}, {"2013-06", type number}, {"2014-06", type number}, {"TTM", type number}}),
    E = Table.DemoteHeaders(D),
    #"Transposed Table" = Table.Transpose(E),
    #"First Row as Header" = Table.PromoteHeaders(#"Transposed Table")
in
    #"First Row as Header"