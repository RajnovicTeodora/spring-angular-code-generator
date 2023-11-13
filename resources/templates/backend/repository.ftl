package ${class.typePackages}.repositories;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;
import com.{nazivApp}.{nazivDrugi}.${class.typePackage}.models.${class.name};

<#assign hasIdProperty = false>
<#list class.properties as property>
  <#if property.name == "id">
    <#assign hasIdProperty = true>
    <#assign idType = property.type>
  </#if>
</#list>

<#if hasIdProperty>


@Repository
public interface ${class.name}Repository extends JpaRepository<${class.name}, ${idType}> {
}
<#else>


@Repository
public interface ${class.name}Repository extends JpaRepository<${class.name}, Long> {
}
</#if>
