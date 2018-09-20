<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">

<#-- Override default number format, otherwise freemarker will automatically write "1000" as "1,000" instead - not what
we would expect! -->
<#setting number_format="computer">

<#assign globalDocumentWidth=1280/>
<#assign globalDocumentHeight=svgDocumentHeight/>
<#assign globalDocumentWidthFormatted=globalDocumentWidth?string("0")/>
<#assign globalDocumentHeightFormatted=globalDocumentHeight?string("0")/>

<svg xmlns:xlink="http://www.w3.org/1999/xlink"
     xmlns="http://www.w3.org/2000/svg"
     id="svgProteinView"
     viewBox="0 0 ${globalDocumentWidthFormatted} ${globalDocumentHeightFormatted}"
     version="1.1">

<#include "resources/css/type_colours_svg.ftl"/>

<#--Protein Accession title-->
    <title>${protein.ac}</title>

    <desc>Auto-generated SVG file produced by InterProScan 5.
        Tested successfully on the following browsers:
        *Mozilla Firefox for Ubuntu Version 15.0.1
        *Chrome/Chromium Version 20.0.1132.47 Ubuntu 12.04
        *Safari ?
        *IE ?
    </desc>
<#include "definitions/defs.ftl"/>

<#--Main box around the protein view-->
    <rect id="background" x="0" y="0" width="${globalDocumentWidthFormatted}" height="${globalDocumentHeightFormatted}"
          style="fill: white;"></rect>
    <rect id="mainBoxBorder"
          x="30px" y="30px" width="${(globalDocumentWidth-60)?string("0")}"
          height="${(globalDocumentHeight - 35)?string("0")}"
          style="fill: white; stroke: lightGrey; stroke-width: 1;"></rect>
    <#--<use x="30px" y="4px" xlink:href="#ico_type_protein"/>-->
    <#--<text x="55px" y="20px" style="fill:#1897E9;font-family:Verdana,Helvetica,sans-serif;-->
                             <#--font-size:20">Protein-->
        <text x="30px" y="20px" style="fill:#1897E9;font-family:Verdana,Helvetica,sans-serif;
                             font-size:20">Protein
    </text>

<#--protein info component-->
<#global proteinInfoComponentHeight=120/>
<#global yPosition=30/>
<#include "component/protein-info-component.ftl"/>

<#--Protein family membership component-->
<#global familyComponentHeight=0/>
<#assign yPosition=yPosition+proteinInfoComponentHeight/>
<#include "component/protein-family-component.ftl"/>

<#--Protein homologous superfamilies summary view component-->
<#global summaryHSViewComponentHeight=0/>
<#assign yPosition=yPosition+familyComponentHeight/>
<#include "component/protein-hs-summary-view-component.ftl"/>

<#--Protein summary view component (domains and repeats)-->
<#global summaryViewComponentHeight=0/>
<#assign yPosition=yPosition+summaryHSViewComponentHeight/>
<#include "component/protein-summary-view-component.ftl"/>

<#--Protein features component-->
<#global proteinFeaturesComponentHeight=0/>
<#assign yPosition=yPosition+summaryViewComponentHeight/>
<#include "component/protein-features-component.ftl"/>

<#--Protein GO terms component-->
<#global proteinXrefComponentHeight=0/>
<#assign yPosition=yPosition+proteinFeaturesComponentHeight/>
<#include "component/protein-xref-component.ftl"/>

    <#--Display InterProScan version number-->
    <g id="versionSection">
    <#assign yPosition=yPosition+proteinXrefComponentHeight+80/>
        <svg x="1050" y="${yPosition?string("0")}" width="1200" height="50" viewBox="0 0 1200 50">
            <text font-size="11px" y="11px" font-family="Verdana, Helvetica, sans-serif" style="fill:#525252;stroke:none;">
                Generated with InterProScan ${interproscanVersion}
            </text>
        </svg>
    </g>

</svg>
