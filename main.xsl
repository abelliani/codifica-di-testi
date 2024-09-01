<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml">

    <xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>

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
                        $("#modifica").click(function () {
                            $(".modifica").css("display", "inline");
                        });
                        $("#hide").click(function () {
                            $(".modifica").hide();
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

                <article class="description">
                    <h2>Descrizione</h2>
                    <xsl:apply-templates select="//tei:physDesc"/>
                    <xsl:apply-templates select="//tei:history"/>
                </article>

                <article>
                    <div id="bottoni">
                        <h2>Modifiche Editoriali</h2>
                        <button id="modifica">Mostra</button>
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

    <xsl:template match="physDesc">
        <div id="info" class="descrizione">
            <p>
                <xsl:value-of select="objectDesc/supportDesc/extent/num"/> pagine precedute da un appunto di
                <xsl:value-of select="objectDesc/supportDesc/extent/persName[@ref='ASA']"/>.
                <xsl:text> </xsl:text>
                <xsl:value-of select="objectDesc/supportDesc/condition"/>. Scritto in
                <xsl:value-of select="objectDesc/typeDesc/p"/>, ogni pagina presenta circa
                <xsl:value-of select="objectDesc/layoutDesc/layout/@ruledLines"/> righe di testo.
                <xsl:value-of select="objectDesc/handDesc/handNote"/>
                <xsl:value-of select="objectDesc/additions/p"/>
            </p>
        </div>
    </xsl:template>

    <xsl:template match="history">
        <div id="history">
            <p>
                Raccolta degli scritti autografi di
                <xsl:value-of select="origin/persName[@ref='EA']"/> accompagnati dalla lettera della madre
                <xsl:value-of select="origin/persName[@ref='ASA']"/>.
                I diari sono composti in due parti. La prima è una fonte di notizie sulla vita culturale torinese di quegli anni e sullo sviluppo della persecuzione razziale.
                La seconda parte, che va dal
                <xsl:value-of select="origin/@from"/> al
                <xsl:value-of select="origin/@to"/>, riguarda l'esperienza partigiana di
                <xsl:value-of select="origin/persName[@ref='EA']"/>.
                Donato per volontà della madre
                <xsl:value-of select="acquisition/persName[@ref='ASA']"/> alla
                <xsl:value-of select="acquisition/orgName/roleName[@type='library']"/>.
            </p>
        </div>
    </xsl:template>



    <xsl:template match="tei:supplied">
        <span class="modifica">
            <xsl:apply-templates />
        </span>
    </xsl:template>

    <xsl:template match="tei:del">
        <span class="modifica">
            <xsl:apply-templates />
        </span>
    </xsl:template>

    <xsl:template match="tei:expan">
        <span class="modifica">
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
