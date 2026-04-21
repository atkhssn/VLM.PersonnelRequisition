using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Radzen;
using VLM.Personnel.Web;
using VLM.Personnel.Web.Services;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

builder.Services.AddScoped(sp => new HttpClient
{
    BaseAddress = new Uri("https://localhost:7072/")
});

builder.Services.AddRadzenComponents();

builder.Services.AddScoped<IApiService, ApiService>();
builder.Services.AddScoped<LookupService>();
builder.Services.AddScoped<RequisitionService>();

await builder.Build().RunAsync();