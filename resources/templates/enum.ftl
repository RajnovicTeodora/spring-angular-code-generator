<#if enum??>
    package ${enum.typePackage};

    public enum ${enum.name?cap_first} {
        <#if enum.values??>
            <#list enum.values as value>
                ${value?upper_case}<#if value?is_last>; <#else>,</#if>
            </#list>
        </#if>
    }
</#if>
