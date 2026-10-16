<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" doctype-system="about:legacy-compat"/>
<xsl:template match="/rss"><html lang="zh-CN"><head><meta charset="utf-8"/><meta name="viewport" content="width=device-width, initial-scale=1"/><title>ZotWatch · 科研文献订阅</title><style>
:root{color-scheme:light;--ink:#243d2c;--muted:#657569;--line:#d8e2d4}*{box-sizing:border-box}
body{margin:0;background:#f6f8f2;color:var(--ink);font:16px/1.7 -apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif}
a{color:#355c3f;text-decoration:none}a:hover{text-decoration:underline}main{max-width:1040px;margin:auto;padding:48px 24px}
.brand{font-size:14px;letter-spacing:.08em;font-weight:700}.hero{padding:30px 0 34px}h1{font-size:clamp(30px,5vw,46px);line-height:1.2;margin:16px 0}
.hero p{color:var(--muted);max-width:650px}.subscribe{padding:22px;background:#eaf0e4;border:1px solid var(--line);border-radius:18px}
.subscribe label{display:block;font-size:13px;margin-bottom:8px}.subscribe input{width:100%;padding:12px;border:1px solid #c5d4bf;border-radius:9px;background:white;color:var(--ink);font:inherit}
.subscribe nav{display:flex;gap:20px;flex-wrap:wrap;margin-top:12px;font-size:14px}.sectionLabel{margin:30px 0 16px;color:var(--muted);font-size:14px}
article{background:white;border:1px solid var(--line);border-radius:18px;padding:26px;margin-bottom:18px;overflow-wrap:anywhere}
article header{display:flex;gap:12px;align-items:center;color:var(--muted);font-size:12px}.number{color:#355c3f;background:#edf3e7;padding:2px 9px;border-radius:6px}
h2{font-size:22px;line-height:1.5;margin:12px 0 18px}h3{font-size:16px;margin:18px 0 6px}.abstract{font-size:15px;color:#3b4d40}.abstract p{margin:10px 0}
.articleLink{display:inline-block;margin-top:18px;font-size:13px;border-top:1px solid var(--line);padding-top:14px;width:100%}
footer{margin-top:32px;color:var(--muted);font-size:13px}@media(max-width:540px){main{padding:24px 16px}article{padding:20px}h2{font-size:20px}}
</style></head><body><main>
<div class="brand">ZW / ZOTWATCH RESEARCH FEED</div><div class="hero"><h1>让值得读的文献<br/>来到你面前。</h1><p>你的科研文献订阅。直接浏览最新推荐，或将下面的链接导入 RSS 阅读器。</p></div>
<div class="subscribe"><label for="feed-url">RSS 订阅链接 · 选择并复制到阅读器</label><input id="feed-url" readonly="readonly" value="{channel/link}"/><nav><a href="index.html">打开完整阅读页 ↗</a><a href="feed.xml">RSS XML ↗</a></nav></div>
<p class="sectionLabel">最近推荐 · <xsl:value-of select="count(channel/item)"/> 篇</p>
<xsl:for-each select="channel/item"><article><header><span class="number"><xsl:value-of select="position()"/></span><time><xsl:value-of select="pubDate"/></time></header><h2><xsl:value-of select="title"/></h2><div class="abstract"><xsl:call-template name="description"><xsl:with-param name="text" select="description"/></xsl:call-template></div><xsl:if test="starts-with(link, 'https://doi.org/') or starts-with(link, 'https://arxiv.org/abs/')"><a class="articleLink" href="{link}" rel="noreferrer" target="_blank">阅读原文 ↗</a></xsl:if></article></xsl:for-each>
<footer>ZotWatch · 只展示文献公开信息；推荐更新后，订阅地址保持不变。</footer></main></body></html></xsl:template>
<!-- Treat description markup as text: never execute or copy arbitrary HTML. -->
<xsl:template name="description"><xsl:param name="text"/>
<xsl:choose><xsl:when test="contains($text, '&lt;')"><xsl:call-template name="entities"><xsl:with-param name="text" select="substring-before($text, '&lt;')"/></xsl:call-template><xsl:variable name="tail" select="substring-after($text, '&lt;')"/><xsl:variable name="tag" select="substring-before($tail, '&gt;')"/><xsl:if test="$tag='br' or $tag='br/' or $tag='/p' or $tag='/div' or $tag='/h3' or $tag='/li'"><br/></xsl:if><xsl:call-template name="description"><xsl:with-param name="text" select="substring-after($tail, '&gt;')"/></xsl:call-template></xsl:when><xsl:otherwise><xsl:call-template name="entities"><xsl:with-param name="text" select="$text"/></xsl:call-template></xsl:otherwise></xsl:choose>
</xsl:template>
<xsl:template name="entities"><xsl:param name="text"/><xsl:choose><xsl:when test="contains($text,'&amp;')"><xsl:value-of select="substring-before($text,'&amp;')"/><xsl:variable name="tail" select="substring-after($text,'&amp;')"/><xsl:choose><xsl:when test="starts-with($tail,'amp;')">&amp;<xsl:call-template name="entities"><xsl:with-param name="text" select="substring($tail,5)"/></xsl:call-template></xsl:when><xsl:when test="starts-with($tail,'lt;')">&lt;<xsl:call-template name="entities"><xsl:with-param name="text" select="substring($tail,4)"/></xsl:call-template></xsl:when><xsl:when test="starts-with($tail,'gt;')">&gt;<xsl:call-template name="entities"><xsl:with-param name="text" select="substring($tail,4)"/></xsl:call-template></xsl:when><xsl:otherwise>&amp;<xsl:call-template name="entities"><xsl:with-param name="text" select="$tail"/></xsl:call-template></xsl:otherwise></xsl:choose></xsl:when><xsl:otherwise><xsl:value-of select="$text"/></xsl:otherwise></xsl:choose></xsl:template>
</xsl:stylesheet>
