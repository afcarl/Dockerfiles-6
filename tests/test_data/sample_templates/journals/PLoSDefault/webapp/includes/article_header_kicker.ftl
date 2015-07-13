<#--
  $HeadURL: http://ambraproject.org/svn/plos/templates/head/journals/PLoSDefault/webapp/includes/article_header_kicker.ftl $
  $Id: article_header_kicker.ftl 12936 2012-11-30 21:54:56Z josowski $

  Copyright (c) 2007-2012 by Public Library of Science
  http://plos.org
  http://ambraproject.org

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->

<div class="article-kicker">
  <#if articleType.heading == "Correction">
    <span class="corr_header"></span>
    <span id="article-type-heading">
      ${articleType.heading}
    </span>
  <#else>
    <#if articleType.heading == "Retraction" || articleType.heading == "Expression of Concern" >
      <span class="eoc-ret-header"></span>
      <span id="article-type-heading" class="eoc-ret">
        ${articleType.heading}
      </span>
    <#else>
      <span id="article-type-heading">
        ${articleType.heading}
      </span>
    </#if>
  </#if>
</div>