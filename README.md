# moralmedia.org

Website for the Media & Morality conference group. It's a [Jekyll](https://jekyllrb.com/) site hosted free on GitHub Pages: every page is a plain text (Markdown) file you can edit right on github.com, and GitHub rebuilds the site about a minute after each change.

All page addresses match the old WordPress site (e.g. `/archives/`, `/annual-meeting-2025/`), so existing links keep working.

---

## Moving the site (one-time)

Do these in order. **Keep WordPress running until step 6** — the images still come from it.

### 1. Download the images and PDFs
On your own computer, unzip this folder, open a terminal in it, and run:

```
bash fetch-wp-uploads.sh
```

It saves 18 images and 2 PDFs into `wp-content/uploads/…` (same paths as on WordPress, so old PDF links still work). If any fail, grab them from the WordPress Media Library and put them at the path it prints.

### 2. Create the GitHub repository
1. On github.com, click **New repository**. Name it e.g. `moralmedia`. Make it **Public** (free Pages needs public, unless you have a paid/education plan). Don't add a README.
2. On the empty repo page, click **uploading an existing file**, drag in **everything inside** this folder (including the hidden-looking `_config.yml`, `_layouts`, `_posts`, `_data` folders and the new `wp-content` folder), and click **Commit changes**.
   - Or use GitHub Desktop: *Add local repository* → this folder → *Publish*.

### 3. Turn on GitHub Pages
Repo → **Settings → Pages** → *Source:* **Deploy from a branch** → Branch **main**, folder **/ (root)** → Save.
After a minute or two the site appears at `https://<your-username>.github.io/moralmedia/`. This preview address works fully, so you can check everything there before touching DNS.

### 4. Connect moralmedia.org
In **Settings → Pages → Custom domain**, enter `moralmedia.org` and save (the `CNAME` file already says this).

Then, wherever the domain's DNS is managed (registrar, or WordPress.com if the domain was bought there), set:

| Type  | Name | Value |
|-------|------|-------|
| A     | @    | 185.199.108.153 |
| A     | @    | 185.199.109.153 |
| A     | @    | 185.199.110.153 |
| A     | @    | 185.199.111.153 |
| AAAA  | @    | 2606:50c0:8000::153 |
| AAAA  | @    | 2606:50c0:8001::153 |
| AAAA  | @    | 2606:50c0:8002::153 |
| AAAA  | @    | 2606:50c0:8003::153 |
| CNAME | www  | `<your-username>.github.io` |

Delete the old A/AAAA/CNAME records that point at WordPress. **Do not touch MX or TXT records** — those carry email.

Once GitHub shows the DNS check as successful (can take up to a day), tick **Enforce HTTPS**.

### 5. Check email still works
`info@moralmedia.org` is used across the site. If that forwarding is set up through the WordPress host, confirm it's still working after the DNS change (send a test message). If it lived on the WordPress plan, set up forwarding at the registrar or with a service like ImprovMX before cancelling.

### 6. Cancel WordPress
Only after the new site loads at moralmedia.org with images, and email works. If the domain is registered through WordPress.com, keep (or transfer) the **domain** registration — cancel only the hosting plan.

---

## Editing the site

| To change… | Edit this file |
|---|---|
| Home page text | `index.html` |
| Upcoming conference (2027) | `moral-media-2027.md` |
| Past conference list | `archives.md` |
| Organizers | `organizers.html` (copy a `<section class="person">` block to add someone) |
| Contact / Resources | `contact.md`, `resources.md` |
| Top menu | `_data/navigation.yml` |
| Colors / fonts | `assets/css/style.css` |

On github.com, open the file, click the ✏️ pencil, edit, then **Commit changes**. The live site updates within a couple of minutes.

**Add an announcement:** in `_posts/`, click *Add file → Create new file*, name it `YYYY-MM-DD-short-title.md`, and paste:

```
---
layout: post
title: "Your title here"
---
Your text here.
```

**Add an image or PDF:** upload it to an `images/` folder (Add file → Upload files), then link it as `{{ site.baseurl }}/images/filename.jpg`. Write links to other pages on the site the same way, e.g. `[Archives]({{ site.baseurl }}/archives/)`, so they work both at the github.io preview address and at moralmedia.org.

**Start a new conference page:** copy `moral-media-2027.md`, change the `title` and `permalink`, and update `_data/navigation.yml` to point at it. Move the old one into `archives.md`.

Markdown basics: `## Heading`, `**bold**`, `*italic*`, `[link text](https://…)`, `- bullet`.
