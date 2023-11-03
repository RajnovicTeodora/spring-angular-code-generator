package ${enum.typePackage}.enumeration;

public enum ${enum.name?cap_first} {
    <#list enum.values as value>
        ${value?upper_case}<#if value?is_last>; <#else>,</#if>
    </#list>
}