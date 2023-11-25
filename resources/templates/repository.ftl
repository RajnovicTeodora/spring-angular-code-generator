package ${class.typePackage}.repository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;
import ${class.typePackage}.model.${class.getName()};


<#assign hasIdProperty = false>
<#list class.properties as property>
  <#if property.getName() == "id">
    <#assign hasIdProperty = true>
    <#assign idType = property.type>
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
