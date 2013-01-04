[{capture append="oxidBlock_pageBody"}]
    [{if $oView->showRDFa()}]
        [{ include file="rdfa/rdfa.tpl" }]
    [{/if}]
    <div id="page">
        <div id="content">
            [{include file="widget/navigation.tpl"}]
            [{include file="message/errors.tpl"}]
            [{foreach from=$oxidBlock_content item="_block"}]
                [{$_block}]
            [{/foreach}]
        </div>
    </div>
    <br />
    <br />
    [{if $oView->isPriceCalculated() }]
        [{block name="layout_page_vatinclude"}]
        [{oxifcontent ident="oxdeliveryinfo" object="oCont"}]
            <div id="incVatMessage">
                [{if $oView->isVatIncluded()}]
                    * <span class="deliveryInfo">[{ oxmultilang ident="PLUS_SHIPPING" }]<a href="[{ $oCont->getLink() }]" rel="nofollow">[{ oxmultilang ident="PLUS_SHIPPING2" }]</a></span>
                [{else}]
                    * <span class="deliveryInfo">[{ oxmultilang ident="PLUS" }]<a href="[{ $oCont->getLink() }]" rel="nofollow">[{ oxmultilang ident="PLUS_SHIPPING2" }]</a></span>
                [{/if}]
            </div>
        [{/oxifcontent }]
        [{/block}]
    [{/if}]
[{/capture}]
[{include file="layout/base.tpl"}]