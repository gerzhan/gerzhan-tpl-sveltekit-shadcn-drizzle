<script lang="ts">
  import { PUBLIC_SYSTEM_NAME, PUBLIC_DOMAIN_NAME } from '$env/static/public';
  const systemName = PUBLIC_SYSTEM_NAME;
  const domainName = PUBLIC_DOMAIN_NAME;
</script>

<h1 class="bg-green-400">Welcome to {systemName}</h1>
<p>
  Visit <a class="text-red-600" href="https://{domainName}">{domainName}</a> to read the documentation
</p>
