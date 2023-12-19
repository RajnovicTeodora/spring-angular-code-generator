package ${class.typePackage}.repository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;
import ${class.typePackage}.model.${class.getName()};


<#assign hasIdProperty = false>
<#list properties as property>
 <#--<#if property.type == "String" && property.type == "boolean" && property.type == "byte" && property.type == "int" && property.type == "float" && property.type == "Integer" && property.type == "double" && property.type == "short" && property.type == "long" && property.type == "char">-->
 <#if property.class.name == "myplugin.generator.fmmodel.FMPrimitiveProperty">
  <#if property.generationType?exists && property.generationType != null>
  <#if property.generationType.getName() == "IDENTITY">
    <#assign hasIdProperty = true>
    <#assign idType = property.type>
    ${idType}
  </#if>
  </#if>
  </#if>
</#list>


<#if hasIdProperty>
@Repository
public interface ${class.getName()}Repository extends JpaRepository<${class.getName()}, ${idType}> {
}
<#else>

@Repository
public interface ${class.getName()}Repository extends JpaRepository<${class.getName()}, Long> {
}
</#if>