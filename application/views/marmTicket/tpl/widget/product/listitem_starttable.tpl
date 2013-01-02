[{assign var="inBasket" value=false}]
[{assign var="basketAmount" value=0}]
[{assign var="basketProductPrice" value=0}]
[{foreach from=$miniBasketList item="basketProduct}]
    [{if $basketProduct->getProductId() == $product->oxarticles__oxid->value}]
        [{assign var="basketProduct" value="$basketProduct"}]
        [{assign var="basketProductPrice" value="$basketProduct->getFTotalPrice()}]
        [{assign var="inBasket" value=true}]
        [{assign var="basketAmount" value=$basketProduct->getAmount()}]
    [{/if}]
[{/foreach}]
[{block name="widget_product_listitem_infogrid"}]
 <form name="tobasket[{$testid}]" [{if $blShowToBasket}]action="[{ $oViewConf->getSelfActionLink() }]" method="post"[{else}]action="[{$_productLink}]" method="get"[{/if}]>
 <tr class="productData">
    <td>
        <h2>[{ $product->oxarticles__oxtitle->value }]</h2>
        [{ $product->oxarticles__oxshortdesc->value }]
    </td>
    <td>
   [{assign var='_productLink' value='#'}]
    [{assign var="blShowToBasket" value=true}] [{* tobasket or more info ? *}]
    [{if $blDisableToCart || $product->isNotBuyable()||($aVariantSelections&&$aVariantSelections.selections)||$product->hasMdVariants()||($oViewConf->showSelectListsInList() && $product->getSelections(1))||$product->getVariants()}]
        [{assign var="blShowToBasket" value=false}]
    [{/if}]

   [{ $oViewConf->getNavFormParams() }]
        [{ $oViewConf->getHiddenSid() }]
        <input type="hidden" name="pgNr" value="[{ $oView->getActPage() }]">
        [{if $recommid}]
            <input type="hidden" name="recommid" value="[{ $recommid }]">
        [{/if}]
        [{ if $blShowToBasket}]
            [{oxhasrights ident="TOBASKET"}]
                <input type="hidden" name="cl" value="[{ $oViewConf->getActiveClassName() }]">
                [{if $owishid}]
                    <input type="hidden" name="owishid" value="[{$owishid}]">
                [{/if}]
                <input type="hidden" name="fnc" value="tobasket">
                <input type="hidden" name="aid" value="[{ $product->oxarticles__oxid->value }]">
                [{if $altproduct}]
                    <input type="hidden" name="anid" value="[{ $altproduct }]">
                [{else}]
                    <input type="hidden" name="anid" value="[{ $product->oxarticles__oxnid->value }]">
                [{/if}]
            [{/oxhasrights}]
        [{else}]
            <input type="hidden" name="cl" value="details">
            <input type="hidden" name="anid" value="[{ $product->oxarticles__oxnid->value }]">
        [{/if}]
   verfügbar: [{ $product->oxarticles__oxstock->value }] </td><td>
        <select name="am" [{if $blShowToBasket}]onchange="this.form.submit()"[{else}]disabled="disabled"[{/if}]>
            <option value="0" [{if $basketAmount==0}] selected="selected"[{/if}]>0</option>
            <option value="1" [{if $basketAmount==1}] selected="selected"[{/if}]>1</option>
            <option value="2" [{if $basketAmount==2}] selected="selected"[{/if}]>2</option>
            <option value="3" [{if $basketAmount==3}] selected="selected"[{/if}]>3</option>
            <option value="4" [{if $basketAmount==4}] selected="selected"[{/if}]>4</option>
            <option value="5" [{if $basketAmount==5}] selected="selected"[{/if}]>5</option>
            <option value="6" [{if $basketAmount==6}] selected="selected"[{/if}]>6</option>
            <option value="7" [{if $basketAmount==7}] selected="selected"[{/if}]>7</option>
            <option value="8" [{if $basketAmount==8}] selected="selected"[{/if}]>8</option>
            <option value="9" [{if $basketAmount==9}] selected="selected"[{/if}]>9</option>
            <option value="10" [{if $basketAmount==10}] selected="selected"[{/if}]>10</option>
        </select>
</td><td>
                    [{block name="widget_product_listitem_infogrid_price"}]
                        [{oxhasrights ident="SHOWARTICLEPRICE"}]
                            [{assign var=tprice value=$product->getTPrice()}]
                            [{assign var=price  value=$product->getPrice()}]
                            [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                                <span class="oldPrice">[{ oxmultilang ident="WIDGET_PRODUCT_PRODUCT_REDUCEDFROM" }] <del>[{ $product->getFTPrice()}] [{ $currency->sign}]</del></span>
                            [{/if}]
                            [{block name="widget_product_listitem_infogrid_price_value"}]
                                [{if $product->getFPrice()}]
                                        [{if $product->isRangePrice()}]
                                                [{ oxmultilang ident="PRICE_FROM" }]
                                                [{if !$product->isParentNotBuyable() }]
                                                    [{ $product->getFMinPrice() }]
                                                [{else}]
                                                    [{ $product->getFVarMinPrice() }]
                                                [{/if}]
                                        [{else}]
                                                [{if !$product->isParentNotBuyable() }]
                                                    [{ $product->getFPrice() }]
                                                [{else}]
                                                    [{ $product->getFVarMinPrice() }]
                                                [{/if}]
                                        [{/if}]
                                    [{ $currency->sign}]
                                [{/if}]
                            [{/block}]
                        [{/oxhasrights}]
                    [{/block}]
   </td>
    <td>
        [{if $inBasket}]
            [{$basketProductPrice}] [{ $currency->sign}] *
        [{else}]
            0,00 € *
        [{/if}]
    </td>
</tr>
</form>
[{/block}]
