<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Google Pay - Sign In</title>
    <style>
      @import url('https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&family=Roboto:wght@300;400;500&display=swap');

      *, *::before, *::after {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
      }

      :root {
        --google-blue:   #4285F4;
        --google-red:    #EA4335;
        --google-yellow: #FBBC05;
        --google-green:  #34A853;
        --surface:       #ffffff;
        --bg:            #f8f9fa;
        --text-primary:  #202124;
        --text-secondary:#5f6368;
        --border:        #dadce0;
        --focus:         #1a73e8;
        --error:         #d93025;
        --btn-bg:        #1a73e8;
        --btn-hover:     #1765cc;
        --shadow-sm:     0 1px 3px rgba(60,64,67,.15), 0 1px 2px rgba(60,64,67,.3);
        --shadow-md:     0 4px 12px rgba(60,64,67,.15), 0 2px 6px rgba(60,64,67,.12);
      }

      body {
        font-family: 'Roboto', sans-serif;
        background: var(--bg);
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        color: var(--text-primary);
      }

      /* ── NAV ── */
      nav {
        position: fixed;
        top: 0;
        width: 100%;
        padding: 16px 24px;
        display: flex;
        align-items: center;
        gap: 12px;
        background: var(--surface);
        border-bottom: 1px solid var(--border);
        z-index: 100;
      }

      nav .nav-logo {
        display: flex;
        align-items: center;
        gap: 10px;
        text-decoration: none;
      }

      nav .nav-logo img {
        height: 28px;
        width: auto;
      }

      nav .nav-logo span {
        font-family: 'Google Sans', sans-serif;
        font-size: 20px;
        font-weight: 500;
        color: var(--text-primary);
        letter-spacing: -.3px;
      }

      /* ── BACKGROUND BLOBS ── */
      .bg-blobs {
        position: fixed;
        inset: 0;
        overflow: hidden;
        pointer-events: none;
        z-index: 0;
      }

      .bg-blobs span {
        position: absolute;
        border-radius: 50%;
        filter: blur(80px);
        opacity: .12;
      }

      .bg-blobs span:nth-child(1) {
        width: 480px; height: 480px;
        background: var(--google-blue);
        top: -120px; left: -120px;
        animation: drift 14s ease-in-out infinite alternate;
      }

      .bg-blobs span:nth-child(2) {
        width: 380px; height: 380px;
        background: var(--google-green);
        bottom: -80px; right: 10%;
        animation: drift 18s ease-in-out infinite alternate-reverse;
      }

      .bg-blobs span:nth-child(3) {
        width: 280px; height: 280px;
        background: var(--google-yellow);
        top: 30%; right: -60px;
        animation: drift 22s ease-in-out infinite alternate;
      }

      @keyframes drift {
        from { transform: translate(0, 0) scale(1); }
        to   { transform: translate(40px, 30px) scale(1.08); }
      }

      /* ── CARD ── */
      .card {
        position: relative;
        z-index: 1;
        background: var(--surface);
        border: 1px solid var(--border);
        border-radius: 28px;
        box-shadow: var(--shadow-md);
        padding: 48px 44px 40px;
        width: 100%;
        max-width: 440px;
        margin-top: 80px;
        animation: slideUp .45s cubic-bezier(.22,1,.36,1) both;
      }

      @keyframes slideUp {
        from { opacity: 0; transform: translateY(24px); }
        to   { opacity: 1; transform: translateY(0); }
      }

      /* ── HEADER ── */
      .card-header {
        text-align: center;
        margin-bottom: 32px;
      }

      .gpay-icon {
        width: 64px;
        height: 64px;
        margin: 0 auto 16px;
        display: block;
      }

      .card-header h1 {
        font-family: 'Google Sans', sans-serif;
        font-size: 24px;
        font-weight: 400;
        color: var(--text-primary);
        margin-bottom: 6px;
      }

      .card-header p {
        font-size: 14px;
        color: var(--text-secondary);
        line-height: 1.5;
      }

      /* ── FORM ── */
      .form-group {
        position: relative;
        margin-bottom: 20px;
      }

      .form-group input {
        width: 100%;
        padding: 14px 16px;
        border: 1.5px solid var(--border);
        border-radius: 8px;
        font-size: 16px;
        font-family: 'Roboto', sans-serif;
        color: var(--text-primary);
        background: transparent;
        outline: none;
        transition: border-color .2s, box-shadow .2s;
      }

      .form-group input:focus {
        border-color: var(--focus);
        box-shadow: 0 0 0 3px rgba(26,115,232,.15);
      }

      .form-group input:focus + label,
      .form-group input:not(:placeholder-shown) + label {
        top: -10px;
        left: 12px;
        font-size: 12px;
        color: var(--focus);
        background: var(--surface);
        padding: 0 4px;
      }

      .form-group label {
        position: absolute;
        left: 16px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 15px;
        color: var(--text-secondary);
        background: transparent;
        transition: all .18s ease;
        pointer-events: none;
      }

      /* ── PHONE FIELD ── */
      .phone-wrapper {
        display: flex;
        gap: 8px;
      }

      .country-code {
        flex: 0 0 88px;
        padding: 14px 10px;
        border: 1.5px solid var(--border);
        border-radius: 8px;
        font-size: 15px;
        font-family: 'Roboto', sans-serif;
        color: var(--text-primary);
        background: var(--bg);
        outline: none;
        cursor: pointer;
        transition: border-color .2s;
      }

      .country-code:focus {
        border-color: var(--focus);
      }

      .phone-input-wrap {
        flex: 1;
        position: relative;
      }

      /* ── SHOW/HIDE PASSWORD ── */
      .input-icon {
        position: absolute;
        right: 14px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
        color: var(--text-secondary);
        display: flex;
        align-items: center;
      }

      .input-icon svg {
        width: 20px;
        height: 20px;
      }

      /* ── HELPERS ── */
      .form-options {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 28px;
        font-size: 13px;
      }

      .remember-me {
        display: flex;
        align-items: center;
        gap: 6px;
        color: var(--text-secondary);
        cursor: pointer;
        user-select: none;
      }

      .remember-me input[type="checkbox"] {
        width: 15px; height: 15px;
        accent-color: var(--focus);
        cursor: pointer;
      }

      .form-options a {
        color: var(--focus);
        text-decoration: none;
        font-weight: 500;
        font-size: 13px;
      }

      .form-options a:hover { text-decoration: underline; }

      /* ── BUTTON ── */
      .btn-primary {
        width: 100%;
        padding: 14px;
        background: var(--btn-bg);
        color: #fff;
        border: none;
        border-radius: 8px;
        font-family: 'Google Sans', sans-serif;
        font-size: 15px;
        font-weight: 500;
        letter-spacing: .25px;
        cursor: pointer;
        transition: background .18s, box-shadow .18s, transform .1s;
        margin-bottom: 16px;
      }

      .btn-primary:hover {
        background: var(--btn-hover);
        box-shadow: 0 2px 8px rgba(26,115,232,.4);
      }

      .btn-primary:active { transform: scale(.98); }

      /* ── DIVIDER ── */
      .divider {
        display: flex;
        align-items: center;
        gap: 12px;
        margin: 20px 0;
        color: var(--text-secondary);
        font-size: 13px;
      }

      .divider::before,
      .divider::after {
        content: '';
        flex: 1;
        height: 1px;
        background: var(--border);
      }

      /* ── GOOGLE SIGN-IN BUTTON ── */
      .btn-google {
        width: 100%;
        padding: 13px;
        background: var(--surface);
        color: var(--text-primary);
        border: 1.5px solid var(--border);
        border-radius: 8px;
        font-family: 'Google Sans', sans-serif;
        font-size: 15px;
        font-weight: 500;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        transition: background .18s, box-shadow .18s;
        text-decoration: none;
      }

      .btn-google:hover {
        background: #f6fafe;
        box-shadow: var(--shadow-sm);
      }

      .btn-google img {
        width: 20px;
        height: 20px;
      }

      /* ── FOOTER TEXT ── */
      .card-footer {
        text-align: center;
        margin-top: 24px;
        font-size: 13px;
        color: var(--text-secondary);
      }

      .card-footer a {
        color: var(--focus);
        font-weight: 500;
        text-decoration: none;
      }

      .card-footer a:hover { text-decoration: underline; }

      .recaptcha-note {
        text-align: center;
        font-size: 11px;
        color: var(--text-secondary);
        margin-top: 20px;
        line-height: 1.6;
        max-width: 340px;
        margin-inline: auto;
      }

      .recaptcha-note a { color: var(--focus); text-decoration: none; }
      .recaptcha-note a:hover { text-decoration: underline; }

      /* ── COLOR BAR ── */
      .google-bar {
        height: 4px;
        border-radius: 28px 28px 0 0;
        background: linear-gradient(90deg,
          var(--google-blue)   0%   25%,
          var(--google-red)    25%  50%,
          var(--google-yellow) 50%  75%,
          var(--google-green)  75% 100%);
        margin: -48px -44px 40px;
        border-radius: 28px 28px 0 0;
      }

      /* ── RESPONSIVE ── */
      @media (max-width: 480px) {
        .card {
          border-radius: 0;
          border-left: none;
          border-right: none;
          padding: 40px 24px 32px;
          margin-top: 60px;
        }

        .google-bar { margin: -40px -24px 32px; }
      }
    </style>
  </head>
  <body>

    <!-- NAV -->
    <nav>
      <a href="#" class="nav-logo">
        <!-- Google Pay SVG logo -->
        <svg class="gpay-icon" style="height:28px;width:auto;" viewBox="0 0 64 26" fill="none" xmlns="http://www.w3.org/2000/svg">
          <text font-family="Google Sans,sans-serif" font-size="22" font-weight="700" fill="#4285F4" x="0" y="22">G</text>
          <text font-family="Google Sans,sans-serif" font-size="22" font-weight="400" fill="#202124" x="16" y="22">Pay</text>
        </svg>
        <span>Google Pay</span>
      </a>
    </nav>

    <!-- BACKGROUND BLOBS -->
    <div class="bg-blobs">
      <span></span><span></span><span></span>
    </div>

    <!-- CARD -->
    <div class="card">
      <div class="google-bar"></div>

      <div class="card-header">
        <!-- Google Pay G logo SVG -->
        <svg class="gpay-icon" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg">
          <circle cx="32" cy="32" r="32" fill="#f8f9fa"/>
          <text font-family="Google Sans,Arial,sans-serif" font-size="38" font-weight="700"
                fill="#4285F4" text-anchor="middle" dominant-baseline="central" x="32" y="33">G</text>
        </svg>
        <h1>Sign in to Google Pay</h1>
        <p>Use your Google Account to pay securely</p>
      </div>

      <!-- FORM -->
      <form action="<%= request.getContextPath() %>/login" method="post" id="loginForm" onsubmit="return validateForm()">

        <!-- CSRF Token -->
        <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") != null ? session.getAttribute("csrfToken") : "" %>" />

        <!-- Mobile Number -->
        <div class="form-group">
          <div class="phone-wrapper">
            <select class="country-code" name="countryCode" id="countryCode" aria-label="Country code">
              <option value="+91">🇮🇳 +91</option>
              <option value="+1">🇺🇸 +1</option>
              <option value="+44">🇬🇧 +44</option>
              <option value="+61">🇦🇺 +61</option>
              <option value="+971">🇦🇪 +971</option>
            </select>
            <div class="phone-input-wrap">
              <input
                type="tel"
                id="mobile"
                name="mobile"
                placeholder=" "
                maxlength="10"
                pattern="[0-9]{10}"
                autocomplete="tel"
                required
              />
              <label for="mobile">Mobile number</label>
            </div>
          </div>
        </div>

        <!-- Password -->
        <div class="form-group">
          <input
            type="password"
            id="password"
            name="password"
            placeholder=" "
            autocomplete="current-password"
            required
          />
          <label for="password">Password</label>
          <span class="input-icon" onclick="togglePassword()" title="Show/hide password">
            <svg id="eyeIcon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
              <circle cx="12" cy="12" r="3"/>
            </svg>
          </span>
        </div>

        <!-- Options -->
        <div class="form-options">
          <label class="remember-me">
            <input type="checkbox" id="rememberMe" name="rememberMe" />
            Remember me
          </label>
          <a href="#">Forgot password?</a>
        </div>

        <!-- Submit -->
        <button type="submit" class="btn-primary">Sign in to Google Pay</button>

      </form>

      <!-- Divider -->
      <div class="divider">or</div>

      <!-- Google SSO -->
      <a href="<%= request.getContextPath() %>/oauth/google" class="btn-google">
        <img src="https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg" alt="Google" />
        Continue with Google
      </a>

      <!-- Footer -->
      <div class="card-footer" style="margin-top:20px;">
        New to Google Pay? <a href="<%= request.getContextPath() %>/register">Create account</a>
      </div>
    </div>

    <!-- reCAPTCHA note -->
    <p class="recaptcha-note">
      This page is protected by Google reCAPTCHA to ensure you're not a bot.
      <a href="https://policies.google.com/privacy">Learn more.</a>
    </p>

    <script>
      /* ── Toggle password visibility ── */
      function togglePassword() {
        const pwd = document.getElementById('password');
        const icon = document.getElementById('eyeIcon');
        if (pwd.type === 'password') {
          pwd.type = 'text';
          icon.innerHTML = `
            <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8
                     a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4
                     c7 0 11 8 11 8 a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07
                     a3 3 0 1 1-4.24-4.24"/>
            <line x1="1" y1="1" x2="23" y2="23"/>`;
        } else {
          pwd.type = 'password';
          icon.innerHTML = `
            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
            <circle cx="12" cy="12" r="3"/>`;
        }
      }

      /* ── Client-side validation ── */
      function validateForm() {
        const mobile = document.getElementById('mobile').value.trim();
        const password = document.getElementById('password').value;

        if (!/^\d{10}$/.test(mobile)) {
          alert('Please enter a valid 10-digit mobile number.');
          return false;
        }
        if (password.length < 6) {
          alert('Password must be at least 6 characters.');
          return false;
        }
        return true;
      }

      /* ── Only allow digits in mobile field ── */
      document.getElementById('mobile').addEventListener('input', function () {
        this.value = this.value.replace(/\D/g, '').slice(0, 10);
      });
    </script>

  </body>
</html>
