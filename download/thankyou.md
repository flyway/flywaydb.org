---
layout: default
tab: download
title: "Thank you for downloading Flyway!"
hideNewsletterFooterForm: true
---
# Thank you for downloading Flyway!

Your download should start shortly. If it doesn't begin automatically <a id="manual-dl" href="">click here</a>.

<div class="row">
<div class="col-md-6">
<h2>Never miss an update</h2>

<p>Subscribe to our newsletter to stay updated about Flyway.</p>

<p>Our newsletter is low-frequency (around one email per month),
it is highly relevant for Flyway users and there is an unsubscribe link in each email.</p>

<p class="note">Needless to say, we hate spam just as much as you do and we will <i>never</i> share or sell your email address.</p>

{% include newsletter.html %}

</div>
<div class="col-md-6">
<h2>New to Flyway?</h2>
In our <a href="/getstarted">Get Started section</a> you'll find a whole collection of 5-10 minute tutorials to get you 
up to speed in no time on both basic and more advanced topics.
</div>
</div>

<script type="text/javascript">
    $(function () {
        var dl = new URL(window.location.href).searchParams.get("dl");
        $("#manual-dl").attr("href", dl);
        downloadDeferred(dl);
    });
</script>
