<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml">

    <xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

    <xsl:key name="pages" match="tei:ab" use="@n"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Progetto di Codifica di Testi - Diari di E. Artom</title>
                <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css" />
                <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
                <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
                <link href="style.css" rel="stylesheet" type="text/css"/>
                <script>
                    $(document).ready(function () {
                        $("#supplied").click(function () {
                            $(".supplied").css("display", "inline");
                        });
                        $("#del").click(function () {
                            $(".del").css("display", "inline");
                        });
                        $("#expan").click(function () {
                            $(".expan").css("display", "inline");
                        });
                        $("#hide").click(function () {
                            $(".supplied, .del, .expan").hide();
                        });
                    });
                </script>   
            </head>
            <body>
                <header>
                    <div id="indice" class="descrizione">
                        <h2>Indice</h2>
                        <ul>
                            <xsl:for-each select="//tei:ab">
                                <li><a href="#pag{generate-id()}">Pagina <xsl:value-of select="@n"/></a></li>
                            </xsl:for-each>
                        </ul>
                    </div>
                </header>

                <div id="info" class="descrizione">
                    <article class="description">
                        <h2>Descrizione</h2>
                        <div>
                            <ul>
                                <li>
                                    <h3>Manoscritto</h3>
                                    <p>172 fogli di carta scritti da Emanuele Artom e 2 pagine iniziali contenenti un appunto della madre Amalia Segre Artom.
                                        Il manoscritto si presenta in buone condizioni e leggibile, con poche eccezioni dovute a cancellature e macchie. Scritto in corsivo, ogni pagina presenta circa 22 righe di testo.
                                    </p>
                                </li>
                            </ul>
                            <div id="history">
                                <ul>
                                    <li>
                                        <h3>Storia</h3>
                                        <p>Raccolta degli scritti autografi di Emanuele Artom accompagnati dalla lettera della madre Amalia Segre Artom.
                                            I diari sono composti in due parti. La prima è una fonte di notizie sulla vita culturale torinese di quegli anni e sullo sviluppo della persecuzione razziale.
                                            La seconda parte, che va dal novembre 1943 al 23 febbraio 1944 riguarda invece l'esperienza partigiana di Emanuele Artom.
                                        </p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </article>
                </div>

                <article>
                    <div id="bottoni">
                        <h2>Visualizza</h2>
                        <button id="supplied">Supplied</button>
                        <button id="expan">Expan</button>
                        <button id="del">Del</button>
                        <button id="hide">Nascondi</button>
                    </div>
                </article>

                <xsl:for-each select="//tei:ab">
                    <xsl:variable name="pageNumber" select="@n"/>
                    <article id="pag{generate-id()}">
                        <h2>Pagina <xsl:value-of select="@n"/></h2>
                        <div class="imageDisplay">
                            <xsl:variable name="imagePath" select="//tei:surface[@xml:id=concat('pag', $pageNumber)]/tei:graphic/@url"/>
                            <img class="image">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="$imagePath"/>
                                </xsl:attribute>
                            </img>
                            <div class="pageDisplay">
                                <xsl:apply-templates select="." />
                            </div>
                        </div>
                    </article>
                </xsl:for-each>
                <footer>
                    <article id="footer">
                        <h3>Informazioni sul Manoscritto</h3>
                        <p><strong>Titolo:</strong> <xsl:value-of select="//tei:titleStmt/tei:title"/></p>
                        <p><strong>Autore:</strong> <xsl:value-of select="//tei:author/tei:persName"/></p>
                        <p><strong>Edizione:</strong> <xsl:value-of select="//tei:editionStmt/tei:edition"/></p>
                        <p><strong>Data:</strong> <xsl:value-of select="//tei:editionStmt/tei:edition/tei:date"/></p>
                        <p><strong>Responsabili:</strong>
                            <xsl:for-each select="//tei:editionStmt/tei:respStmt">
                                <br/><xsl:value-of select="tei:resp"/>: <xsl:value-of select="tei:name"/>
                            </xsl:for-each>
                        </p>
                        <p><strong>Editore:</strong> <xsl:value-of select="//tei:publicationStmt/tei:publisher"/></p>
                        <p><strong>Luogo di pubblicazione:</strong> <xsl:value-of select="//tei:publicationStmt/tei:pubPlace"/></p>
                        <p><strong>Disponibilità:</strong> <xsl:value-of select="//tei:publicationStmt/tei:availability/tei:p"/></p>
                        <p><strong>Anno di pubblicazione:</strong> <xsl:value-of select="//tei:publicationStmt/tei:date/@when"/></p>
                        <p><strong>Identificatore:</strong>
                            <xsl:value-of select="//tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:idno"/>
                        </p>
                        <p><strong>Istituzione:</strong>
                            <xsl:value-of select="//tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:institution"/>
                        </p>
                        <p><strong>Collezione:</strong>
                            <xsl:value-of select="//tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:collection"/>
                        </p>
                        <p><strong>Luogo:</strong>
                            <xsl:value-of select="//tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:settlement"/>
                        </p>
                        <p><strong>Nazione:</strong>
                            <xsl:value-of select="//tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:country"/>
                        </p>
                    </article>
                </footer>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:supplied">
        <span class="supplied">
            <xsl:apply-templates />
        </span>
    </xsl:template>

    <xsl:template match="tei:del">
        <span class="del">
            <xsl:apply-templates />
        </span>
    </xsl:template>

    <xsl:template match="tei:expan">
        <span class="expan">
            <xsl:apply-templates />
        </span>
    </xsl:template>

    <xsl:template match="tei:lb">
        <br />
        <span class="line-break">
            <b>
                <xsl:value-of select="@n" />
            </b>
        </span>
    </xsl:template>
</xsl:stylesheet>
