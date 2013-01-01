[{assign var="i" value=1}]
[{assign var="repeat" value=true}]
[{while var="repeat"}]
    [{$i++}]. Teilnemer<br />
    
    [{if $i > $oxcmp_basket->getItemsCount()}]
        [{assign var="repeat" value=false}]
    [{/if}]
[{/while}]