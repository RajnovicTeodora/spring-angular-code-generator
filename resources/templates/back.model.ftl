<#assign hasId = false>
<#assign nameId = "">
<#assign typeId = "">
<#assign hasEnum = false>
<#list primitiveProperties as prim>
  <#if prim.isId>
    <#assign hasId = true>
    <#assign nameId = prim.name>
	<#assign typeId = prim.type>
  </#if>
  <#if prim.isEnum>
    <#assign hasEnum = true>
  </#if>
</#list>
<#lt>package ${class.typePackage}.model;

import lombok.AllArgsConstructor;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;
import java.util.Date;

//import ${class.typePackage}.enumeration.*;
<#if hasEnum == true>import ${class.typePackage}.enumeration.*;</#if>

@AllArgsConstructor
@Entity
<#if (class.tableName)??>@Table(name = "${class.tableName}")</#if>
${class.visibility} class ${class.name}{
	<#if hasId == false>${'\n'}    @Id${'\n'}    @GeneratedValue${'\n'}    private long id;${'\n'} </#if>
	<#list primitiveProperties as property>
	<#if (property)??>  
	<#if (property.generationType)?? && property.isId == true>
	@Id 
	@Column(name = "id", unique = true, nullable = false)
	<#if property.generationType.name() == "IDENTITY">
	<#elseif property.generationType.name() == "SEQUENCE">
	@GeneratedValue(generator = "sequence-generator")
    @GenericGenerator(
      name = "sequence-generator",
      strategy = "org.hibernate.id.enhanced.SequenceStyleGenerator",
      parameters = {
        @Parameter(name = "sequence_name", value = "${class.tableName}_sequence"),
        @Parameter(name = "initial_value", value = "1"),
        @Parameter(name = "increment_size", value = "1")
        }
    )
    <#elseif property.generationType.name() == "TABLE">@GeneratedValue(strategy = GenerationType.TABLE, 
      generator = "table-generator")
    @TableGenerator(name = "table-generator", 
      table = "${class.name?lower_case}_ids", 
      pkColumnName = "seq_id", 
      valueColumnName = "seq_value")
    <#else>
    @GeneratedValue
	</#if>
	<#else>
	@Column(name="${property.columnName?lower_case}"<#if ((property.length)?? ||(property.unique)?? || (property.lower)??)><#rt>
			   <#if (property.length)??>
			       <#lt>, length = ${property.length}<#rt>
			   </#if>
			   <#if (property.unique)??>
			        <#lt>, unique = ${property.unique?c}<#rt>
			   </#if>
			   <#if (property.lower)?? && (property.lower)== 0>
			       <#lt>, nullable = true<#rt>
			   </#if>
			   <#lt>)</#if><#if property.isEnum == true>${'\n'}	@Enumerated(EnumType.STRING)</#if>
	</#if>
	${property.visibility} <#if (property.type)=="date">Date<#elseif (property.generationType)?? && property.generationType.name() == "UUID">UUID<#else>${property.type}</#if> ${property.name?uncap_first};
	
	</#if>	
	</#list>
	@Column(name="deleted", unique = false)
	private boolean deleted;

	<#list referenceProperties as property>
	<#if (property)??>
	<#if (property.upper)?? && (property.cardinality)??>@${property.cardinality}</#if><#rt>
	<#lt><#if (property.fetchType)?? || (property.cascadeType)?? || (property.mappedBy)??>(<#rt>
		<#if (property.cascadeType)??>
			<#lt>cascade = CascadeType.${property.cascadeType.name()}<#rt>
		</#if>
		<#if (property.fetchType)??>
			<#lt><#if (property.cascadeType)??>, </#if>fetch = FetchType.${property.fetchType.name()}<#rt>
		</#if>
		<#if (property.mappedBy)??>
			<#lt><#if (property.cascadeType)?? || (property.fetchType)??>, </#if>mappedBy = "${property.mappedBy}"<#rt>
		</#if>
		<#lt>)		<#if (property.cardinality)?? && (property.cardinality == "ManyToMany") && (property.fetchType)?? && (property.fetchType.name() == "LAZY")>${'\n'}	@JoinTable(name = "${property.name}",${'\n'}            joinColumns = @JoinColumn(name = "<#if (class.tableName)??>${class.tableName}<#else>${(class.name?replace("([A-Z])", "_$1"))?lower_case}</#if>_id", referencedColumnName = "id"),${'\n'}            inverseJoinColumns = @JoinColumn(name = "${property.type?uncap_first}_id", referencedColumnName = "id"))</#if></#if>
	<#if (property.visibility)?? && (property.type)?? && (property.name)??>
	${(property.visibility)} <#rt>
	<#if (property.upper)?? && (property.upper) == -1>
		<#lt>List<<#rt> 
	</#if>
	<#lt>${property.type?cap_first}<#rt>
	<#if (property.upper)?? && (property.upper) == -1>
		<#lt>><#rt> 
	</#if>
	<#lt> ${property.name};
	</#if>
	</#if>
	
	</#list>
	
	public ${class.name}() {}	
	<#if hasId == false>${'\n'}    public long getId(){${'\n'}        return id;${'\n'}    }${'\n'}  	public void setId(long id){${'\n'}       	this.id = id;${'\n'}    }${'\n'}</#if>
	<#list primitiveProperties as property>
	<#if (property)?? && (property.type)?? && (property.name)??>
  	public <#if (property.type)=="date">Date<#elseif (property.generationType)?? && property.generationType.name() == "UUID">UUID<#else>${property.type}</#if> get${property.name?cap_first}(){
    	return ${property.name?uncap_first};
  	}

  	public void set${property.name?cap_first}(<#if (property.type)=="date">Date<#elseif (property.generationType)?? && property.generationType.name() == "UUID">UUID<#else>${property.type}</#if> ${property.name?uncap_first}){
       	this.${property.name?uncap_first} = ${property.name?uncap_first};	
	}
	</#if>
	</#list>
	
	<#list referenceProperties as property>
	<#if (property)?? && (property.type)?? && (property.name)??>
	public <#rt>
	<#if (property.upper)?? && (property.upper) == -1>
		<#lt>List<<#rt> 
	</#if>
	<#lt>${property.type?cap_first}<#rt>
	<#if (property.upper)?? && (property.upper) == -1>
		<#lt>><#rt> 
	</#if>
	<#lt> get${property.name?cap_first}() {
		return ${property.name};
	}

	public void set${property.name?cap_first}(<#rt>
	<#if (property.upper)?? && (property.upper) == -1>
		<#lt>List<<#rt> 
	</#if>
	<#lt>${property.type}<#rt>
	<#if (property.upper)?? && (property.upper) == -1>
		<#lt>><#rt> 
	</#if>
	<#lt> ${property.name?uncap_first}) {
		this.${property.name?uncap_first} = ${property.name?uncap_first};
	}${'\n'}
	</#if>
	</#list>
	public boolean getDeleted() {
		return deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	<#if hasId>
	public ${typeId} getId() { return ${nameId}; }
	</#if>
}