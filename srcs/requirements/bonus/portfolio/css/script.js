// Mobile Navigation Toggle
document.addEventListener("DOMContentLoaded", () => {
  const hamburger = document.querySelector(".hamburger")
  const navMenu = document.querySelector(".nav-menu")
  const socialLinks = document.querySelector(".social-links")

  if (hamburger) {
    hamburger.addEventListener("click", () => {
      hamburger.classList.toggle("active")
      navMenu.classList.toggle("active")
      socialLinks.classList.toggle("active")
    })
  }

  // Close mobile menu when clicking on a link
  const navLinks = document.querySelectorAll(".nav-link")
  navLinks.forEach((link) => {
    link.addEventListener("click", () => {
      hamburger.classList.remove("active")
      navMenu.classList.remove("active")
      socialLinks.classList.remove("active")
    })
  })

  // Smooth scrolling for navigation links
  const links = document.querySelectorAll('a[href^="#"]')
  links.forEach((link) => {
    link.addEventListener("click", function (e) {
      e.preventDefault()
      const targetId = this.getAttribute("href")
      const targetSection = document.querySelector(targetId)

      if (targetSection) {
        const offsetTop = targetSection.offsetTop - 80 // Account for fixed navbar
        window.scrollTo({
          top: offsetTop,
          behavior: "smooth",
        })
      }
    })
  })

  // Add scroll effect to navbar
  window.addEventListener("scroll", () => {
    const navbar = document.querySelector(".navbar")
    if (window.scrollY > 50) {
      navbar.style.background = "rgba(255, 255, 255, 0.98)"
      navbar.style.boxShadow = "0 2px 20px rgba(0, 0, 0, 0.1)"
    } else {
      navbar.style.background = "rgba(255, 255, 255, 0.95)"
      navbar.style.boxShadow = "none"
    }
  })

  // Animate progress bar on scroll
  const progressBar = document.querySelector(".progress-fill")
  const statsSection = document.querySelector(".stats")

  const animateProgressBar = () => {
    const sectionTop = statsSection.offsetTop
    const sectionHeight = statsSection.offsetHeight
    const windowHeight = window.innerHeight
    const scrollTop = window.pageYOffset

    if (scrollTop > sectionTop - windowHeight + sectionHeight / 2) {
      progressBar.style.width = "5.31%"
    }
  }

  window.addEventListener("scroll", animateProgressBar)

  // Add intersection observer for animations
  const observerOptions = {
    threshold: 0.1,
    rootMargin: "0px 0px -50px 0px",
  }

  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.style.opacity = "1"
        entry.target.style.transform = "translateY(0)"
      }
    })
  }, observerOptions)

  // Observe elements for animation
  const animatedElements = document.querySelectorAll(".stat-card, .skill-badge, .achievement-card")
  animatedElements.forEach((el) => {
    el.style.opacity = "0"
    el.style.transform = "translateY(30px)"
    el.style.transition = "opacity 0.6s ease, transform 0.6s ease"
    observer.observe(el)
  })
})

// Add mobile navigation styles
const style = document.createElement("style")
style.textContent = `
    @media (max-width: 768px) {
        .nav-menu.active,
        .social-links.active {
            display: flex;
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            background: white;
            flex-direction: column;
            padding: 1rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .nav-menu.active {
            border-bottom: 1px solid #e2e8f0;
        }
        
        .social-links.active {
            justify-content: center;
            padding: 1rem;
        }
        
        .hamburger.active span:nth-child(1) {
            transform: rotate(-45deg) translate(-5px, 6px);
        }
        
        .hamburger.active span:nth-child(2) {
            opacity: 0;
        }
        
        .hamburger.active span:nth-child(3) {
            transform: rotate(45deg) translate(-5px, -6px);
        }
    }
`
document.head.appendChild(style)
