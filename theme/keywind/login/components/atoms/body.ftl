<#macro kw>
  <body class="text-[var(--kw-text)] antialiased flex flex-col font-sans items-center justify-center min-h-screen overflow-hidden px-4 py-12 sm:py-20 relative">
    <!-- Clean animated landscape background -->
    <div class="landscape absolute inset-0 z-[-1]" aria-hidden="true">
      <svg xmlns="http://www.w3.org/2000/svg" class="w-full h-full" viewBox="0 0 1440 800" preserveAspectRatio="xMidYMid slice">
        <!-- Sun -->
        <circle cx="1080" cy="165" r="68" class="sun-glow"/>
        <circle cx="1080" cy="165" r="42" class="sun"/>

        <!-- Clouds (drifting) -->
        <!-- Cloud 1 - slow -->
        <g class="cloud cloud-slow" style="animation-delay: -25s;">
          <ellipse cx="180" cy="142" rx="68" ry="23"/>
          <ellipse cx="245" cy="128" rx="52" ry="31"/>
          <ellipse cx="295" cy="145" rx="58" ry="22"/>
          <ellipse cx="155" cy="155" rx="32" ry="16"/>
        </g>

        <!-- Cloud 2 - medium -->
        <g class="cloud cloud-medium" style="animation-delay: -52s;">
          <ellipse cx="420" cy="98" rx="52" ry="18"/>
          <ellipse cx="475" cy="86" rx="42" ry="25"/>
          <ellipse cx="515" cy="102" rx="48" ry="17"/>
        </g>

        <!-- Cloud 3 - slow -->
        <g class="cloud cloud-slow" style="animation-delay: -8s;">
          <ellipse cx="720" cy="155" rx="75" ry="26"/>
          <ellipse cx="800" cy="138" rx="58" ry="35"/>
          <ellipse cx="860" cy="158" rx="62" ry="24"/>
          <ellipse cx="680" cy="168" rx="35" ry="18"/>
        </g>

        <!-- Cloud 4 - fast-ish -->
        <g class="cloud cloud-fast" style="animation-delay: -38s;">
          <ellipse cx="1020" cy="82" rx="45" ry="16"/>
          <ellipse cx="1065" cy="72" rx="36" ry="22"/>
          <ellipse cx="1100" cy="85" rx="40" ry="15"/>
        </g>

        <!-- Subtle mist layer -->
        <rect x="0" y="320" width="1440" height="480" class="mist"/>

        <!-- Layered rolling hills (clean, minimal) -->
        <!-- Far hills -->
        <path d="M0,420 Q160,325 340,395 Q510,305 720,380 Q910,310 1090,370 Q1250,320 1440,385 L1440,800 L0,800 Z" class="hill-far"/>
        <!-- Mid hills -->
        <path d="M0,490 Q200,410 410,475 Q620,395 850,460 Q1050,400 1240,455 Q1380,415 1440,460 L1440,800 L0,800 Z" class="hill-mid"/>
        <!-- Front hill -->
        <path d="M0,560 Q280,485 510,545 Q780,470 1030,530 Q1260,475 1440,525 L1440,800 L0,800 Z" class="hill-front"/>
      </svg>
    </div>

    <#nested>
  </body>
</#macro>